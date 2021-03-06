/*
  This model controls what gets served to Fiori frontends...
*/

// 1) the annotated services per app...
using from './webapp/admin/fiori-service';
using from './webapp/approval/fiori-service';
using from './webapp/browse/fiori-service';
using from './webapp/orders/fiori-service';
using from './webapp/role/fiori-service';
using from './webapp/users/fiori-service';

// 2) fiori annotations common to all apps...
using my.bookshop as my from '../db/schema';

annotate my.Authors with @(
    UI: {
        Identification: [{Value:name}],
        SelectionFields: [ ID, name, alive ],
        LineItem: [
            {Value: ID},
            {Value: name},
            {Value: dateOfBirth},
            {Value: placeOfBirth},
            {Value: dateOfDeath},
            {Value: placeOfDeath},
            {Value: country.name},
            {
                $Type: 'UI.DataFieldWithIntentBasedNavigation',
                Label: 'To Books Intent Based',
                Value: ID,
                SemanticObject: 'Books',
                Action: 'displayUI5latest'
            }
        ],
    HeaderInfo: {
      TypeName: 'Author', TypeNamePlural: 'Authors',
      Title: { Value: ID },
      Description: { Value: name }
    },
    Facets: [
            {$Type: 'UI.ReferenceFacet', Label: '{i18n>Details}', Target: '@UI.FieldGroup#Details'},
            {$Type: 'UI.ReferenceFacet', Label: '{i18n>Books}', Target: 'books/@UI.LineItem'},
        ],
        FieldGroup#Details: {
            Data: [
                {Value: name},
                {Value: dateOfBirth},
                {Value: placeOfBirth},
                {Value: dateOfDeath},
                {Value: placeOfDeath},
            ]
        },
    }
);

////////////////////////////////////////////////////////////////////////////
//
//	Books Lists
//
annotate my.Books with @(
    UI: {
        Identification: [{Value:title}],
        SelectionFields: [ ID, title, author.name, stock ],
        LineItem: [
            {Value: ID},
            {Value: title},
            {Value: author.name},
            {
                $Type: 'UI.DataFieldWithIntentBasedNavigation',
                Label: 'To Author Intent Based',
                Value: 'with Intent',
                SemanticObject: 'Authors',
                Action: 'display'
            },
            {
                $Type: 'UI.DataFieldWithUrl',
                Label: 'To Author Url',
                Value: 'with Url',
                Url: semanticURLtoAuthor,
                SemanticObject: 'Authors',
                Action: 'display'
            },
            {
                $Type:'UI.DataFieldWithIntentBasedNavigation',
                Label:'{i18n>Author}',
                Value: author.ID,
                SemanticObject: 'Authors',
                Action: 'display'
            },
            {
                $Type:'UI.DataFieldWithIntentBasedNavigation',
                Label:'{i18n>Author}',
                Value: author.ID,
                SemanticObject: 'Authors',
                Action: 'displayUI5latest'
            },
            {Value: stock},
            {Value: price},
            {Value: currency.symbol, Label:''}
            // {Value: author_ID, Label:'{i18n>AuthorID}'},
            /*
            {
                $Type:'UI.DataFieldWithNavigationPath', 
                Value: author_ID, 
                Label:'{i18n>AuthorID}', 
                Target:'author'
            },
            {
                $Type:'UI.DataFieldWithNavigationPath', 
                Value: author.ID, 
                Label:'Navigate to Author',
                SemanticObject: 'Authors',
                Action: 'manage'
            }
            {
                $Type:'UI.DataFieldForIntentBasedNavigation', 
                Value: author.ID, 
                Label:'Action for Navigation to Author', 
                SemanticObject: 'Authors',
                Action: 'manage'
            }			
            */
            // {Value: author.name},
        ]
    },
) {
    author @(
        // Common.Text: { $value:author.name, "@UI.TextArrangement": #TextOnly },
        ValueList.entity:'Authors',
        // Common.ValueList.Parameters:[
        // 	{ $Type:'Common.ValueListParameterInOut', LocalDataProperty:author_name, ValueListProperty:'name' },
        // ],		
    );
}

////////////////////////////////////////////////////////////////////////////
//
//	Books Details
//
annotate my.Books with @(
    UI: {
      HeaderInfo: {
          TypeName: '{i18n>Book}',
          TypeNamePlural: '{i18n>Books}',
          Title: {Value: title},
          ImageUrl: 'https://raw.githubusercontent.com/gregorwolf/bookshop-demo/master/tests/Test.png',
          Description: {Value: author.name}
      },
    }
);



////////////////////////////////////////////////////////////////////////////
//
//	Books Elements
//
annotate my.Books with {
    ID @title:'{i18n>ID}';
    title @title:'{i18n>Title}';
    author @title:'{i18n>AuthorID}';
    price @title:'{i18n>Price}';
    stock @title:'{i18n>Stock}';
    descr @UI.MultiLineText;
}


////////////////////////////////////////////////////////////////////////////
//
//	Authors Elements
//
annotate my.Authors with {
    ID @title:'{i18n>ID}' @UI.HiddenFilter;
    name @title:'{i18n>AuthorName}';
}
