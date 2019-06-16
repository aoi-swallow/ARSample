# ARSample

### このリポジトリの概要
- ARKitを初めて触った際の超初歩的な使い方メモ
- 現実世界のタップしたところにラーメンが出てくるというしょうもないアプリ

### 準備
今回はAugmented Reality App テンプレートは使ってません
- info.plistに`CameraUsageDescription(String) - 映像を映し出します。`を追加する（カメラの使用許可）
- info.plistの`Required device capabilities`に`item1(String) - arkit`を追加する（ARKitが動くものに動作対象を絞る）
- ストーリーボードにARSCNViewを配置
