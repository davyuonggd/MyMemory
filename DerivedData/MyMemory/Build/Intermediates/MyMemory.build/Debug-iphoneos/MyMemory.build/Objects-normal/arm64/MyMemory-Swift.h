// Generated by Apple Swift version 1.2 (swiftlang-602.0.53.1 clang-602.0.53)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
#if __has_feature(nullability)
#  define SWIFT_NULLABILITY(X) X
#else
# if !defined(__nonnull)
#  define __nonnull
# endif
# if !defined(__nullable)
#  define __nullable
# endif
# if !defined(__null_unspecified)
#  define __null_unspecified
# endif
#  define SWIFT_NULLABILITY(X)
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import ParseUI;
@import Parse;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;
@class NSObject;

SWIFT_CLASS("_TtC8MyMemory11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic) UIWindow * __nullable window;
- (BOOL)application:(UIApplication * __nonnull)application didFinishLaunchingWithOptions:(NSDictionary * __nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * __nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * __nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * __nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * __nonnull)application;
- (void)applicationWillTerminate:(UIApplication * __nonnull)application;
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class PFLogInViewController;
@class PFUser;
@class NSError;
@class PFSignUpViewController;

@interface AppDelegate (SWIFT_EXTENSION(MyMemory)) <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
- (void)loginSetup;
- (BOOL)logInViewController:(PFLogInViewController * __nonnull)logInController shouldBeginLogInWithUsername:(NSString * __nonnull)username password:(NSString * __nonnull)password;
- (void)logInViewController:(PFLogInViewController * __nonnull)logInController didLogInUser:(PFUser * __nonnull)user;
- (void)logInViewController:(PFLogInViewController * __nonnull)logInController didFailToLogInWithError:(NSError * __nullable)error;
- (void)signUpViewController:(PFSignUpViewController * __nonnull)signUpController didSignUpUser:(PFUser * __nonnull)user;
- (void)signUpViewController:(PFSignUpViewController * __nonnull)signUpController didFailToSignUpWithError:(NSError * __nullable)error;
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController * __nonnull)signUpController;
@end

@class Note;
@class UIStoryboardSegue;
@class UITextField;
@class UITextView;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC8MyMemory21NewNoteViewController")
@interface NewNoteViewController : UIViewController
@property (nonatomic) Note * __nullable currentNote;
@property (nonatomic, weak) IBOutlet UITextField * __nullable titleTextField;
@property (nonatomic, weak) IBOutlet UITextView * __nullable contentTextView;
- (void)prepareForSegue:(UIStoryboardSegue * __nonnull)segue sender:(id __nullable)sender;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)displayNote:(Note * __nullable)note;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface NewNoteViewController (SWIFT_EXTENSION(MyMemory)) <UITextViewDelegate>
@end


@interface NewNoteViewController (SWIFT_EXTENSION(MyMemory)) <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField * __nonnull)textField;
@end

@class NSDate;

SWIFT_CLASS("_TtC8MyMemory4Note")
@interface Note : PFObject <PFSubclassing>
@property (nonatomic, copy) NSString * __nullable content;
@property (nonatomic) PFUser * __nullable user;
@property (nonatomic, copy) NSString * __nullable title;
+ (NSString * __nonnull)parseClassName;
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
+ (void)initialize;
@property (nonatomic) NSDate * __nonnull modificationDate;
- (void)uploadNote;
- (void)updateNote:(Note * __nullable)updateNote;
@end

@class NSDateFormatter;
@class UILabel;

SWIFT_CLASS("_TtC8MyMemory17NoteTableViewCell")
@interface NoteTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified titleLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified dateLabel;
+ (NSDateFormatter * __nonnull)dateFormatter;
+ (void)setDateFormatter:(NSDateFormatter * __nonnull)value;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * __nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface PFObject (SWIFT_EXTENSION(MyMemory))
@end

@class UITableView;
@class PFQuery;
@class UISearchBar;

SWIFT_CLASS("_TtC8MyMemory14ViewController")
@interface ViewController : UIViewController
@property (nonatomic) IBOutlet UITableView * __null_unspecified tableView;
@property (nonatomic, weak) IBOutlet UISearchBar * __null_unspecified searchBar;
@property (nonatomic) PFQuery * __nullable query;
@property (nonatomic) Note * __nullable selectedNote;
@property (nonatomic, copy) NSArray * __nonnull notes;
- (IBAction)logoutAction:(id __nonnull)sender;
- (void)viewDidLoad;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillAppear:(BOOL)animated;
- (void)deleteNote:(Note * __nullable)deletingNote;

/// Is called as the completion block of all queries.
/// As soon as a query completes, this method updates the Table View.
- (void)updateList:(NSArray * __nullable)results error:(NSError * __nullable)error;
- (IBAction)unwindToSegue:(UIStoryboardSegue * __nonnull)segue;
- (void)prepareForSegue:(UIStoryboardSegue * __nonnull)segue sender:(id __nullable)sender;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSIndexPath;

@interface ViewController (SWIFT_EXTENSION(MyMemory)) <UITableViewDataSource>
- (NSInteger)tableView:(UITableView * __nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * __nonnull)tableView:(UITableView * __nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
@end


@interface ViewController (SWIFT_EXTENSION(MyMemory)) <UITableViewDelegate>
- (void)tableView:(UITableView * __nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (BOOL)tableView:(UITableView * __nonnull)tableView canEditRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (void)tableView:(UITableView * __nonnull)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
@end


@interface ViewController (SWIFT_EXTENSION(MyMemory)) <UISearchBarDelegate>
- (void)searchBarTextDidBeginEditing:(UISearchBar * __nonnull)searchBar;
- (void)searchBarCancelButtonClicked:(UISearchBar * __nonnull)searchBar;
- (void)searchBar:(UISearchBar * __nonnull)searchBar textDidChange:(NSString * __nonnull)searchText;
@end

#pragma clang diagnostic pop
