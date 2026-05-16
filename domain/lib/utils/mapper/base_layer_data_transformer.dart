import 'package:domain/utils/mapper/layer_data_transformer.dart';

abstract class BaseLayerDataTransformer<F, T>
    extends LayerDataTransformer<F, T> {
  @override
  F restore(T data) {
    throw UnsupportedError('restore must be implemented by subclasses');
  }

  @override
  T transform() {
    throw UnsupportedError('transform must be implemented by subclasses');
  }
}
