import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:searches_clean_arch/modules/search/domain/entities/result_search_entity.dart';
import 'package:searches_clean_arch/modules/search/domain/errors/errors.dart';
import 'package:searches_clean_arch/modules/search/domain/repositories/search_repository_interface.dart';
import 'package:searches_clean_arch/modules/search/domain/usecases/search_by_text.dart';

// Mock by hand for practice
class SearchRepositoryMock implements SearchRepositoryInterface{
  @override
  Future<Either<FailureSearchInterface, List<ResultSearchEntity>>> search(String searchText) async {
    return const Right(<ResultSearchEntity>[]);
  }
}

main(){
  final repository = SearchRepositoryMock();
  final usecase = SearchByText(repository);
  
  test("Must return a ResultSearchEntity list", () async {

    final result = await usecase("searchString"); // automatic execute call method
    expect (result | <ResultSearchEntity>[], isA<List<ResultSearchEntity>>());
  });

  test("Must happen the InvalidSearchTextError exception flow", () async {
    final result = await usecase(""); // automatic execute call method
    expect (result.fold((l) => l, (r) => r), isA<InvalidSearchTextError>());
  });
}