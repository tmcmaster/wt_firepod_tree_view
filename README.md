# wt_firepod_tree_view

Flutter interactive Tree View widget backed by Riverpod and Firebase.

## Examples

```dart
FirepodTreeView.fromList([
    'First',
    {
        'a': 'AA',
        'b': 'BB',
        'c': {
            'cc': 'CC',
            'dd': 'DD',
            'ee': [
                'AAA',
                {
                    'a': 'A',
                    'b': 'B',
                    'c': {
                        'cc': 'C',
                        'dd': 'D',
                        'ee': 'E',
                        'ff': 'F',
                    },
                }, 
                'CCC'
            ],
            'ff': 'FF',
        },
    }, 
    'Last',
    Customer(
        id: '001',
        name: 'Customer 1',
        phone: '040400001',
        email: 'customer+1@example.com',
        address: '1 main street, Pakenham',
        postcode: 3810,
    ),
]);
```

```dart
FirepodTreeView.fromMap(
    {
        'a': 'AA',
        'b': 'BB',
        'c': {
            'cc': 'CC',
            'dd': 'DD',
            'ee': [
                'AAA',
                {
                    'a': 'A',
                    'b': 'B',
                    'c': {
                        'cc': 'C',
                        'dd': 'D',
                        'ee': 'E',
                        'ff': 'F',
                    },
                }, 
                'CCC'
            ],
            'ff': 'FF',
        },
    }
);

```