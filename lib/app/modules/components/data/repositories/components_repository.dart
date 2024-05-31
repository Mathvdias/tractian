import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/modules/components/data/adapters/request_components_list_adapter.dart';
import 'package:tractian/app/modules/components/interactor/interactor.dart';

final class ComponentsRepositoryImpl extends IComponentsRepository {
  final IRestClient restClient;

  ComponentsRepositoryImpl(this.restClient);

  @override
  Future<Output<RequestComponentsListEntity>> call(String companyId) async {
    try {
      final response =
          await restClient.get(RestClientRequest(path: env.assets(companyId)));

      final parsedData = await compute(parseJson, json.encode(response.data));

      return Success(parsedData);
    } on RestClientException catch (e) {
      return Error(e);
    }
  }
}
