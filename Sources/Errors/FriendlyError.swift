//
//  Created by Ettore Pasquini on 3/13/24.
//  Copyright © 2024 The New York Public Library. All Rights Reserved.
//

/// A protocol that all `Error` subclass should extend to support user and
/// developer friendly error messaging (and logging) inside the NYPL eReader.
///
/// - Important: different errors -- with different underlying causes and
/// developer friendly descriptions / errorIDs -- may have the same user
/// friendly description.
public protocol FriendlyError: Error {

    /// A localized description of the error that will be understandable by
    /// most users of the app.
    var userFriendlyMessage: String {get}

    /// A very short lowercase string common to related errors.
    var domain: String {get}

    /// A very short lowercase string identifying the error within the `domain`.
    var code: String {get}

    // MARK: Properties with default implementations

    /// A localized description of the error that will be understandable by
    /// most users of the app and that provides the `errorID`.
    ///
    /// **Default implementation provided.**
    ///
    /// - Important: there's a 1-many relation between this and
    /// `devFriendlyDescription` / `errorID`.
    var userFriendlyDescription: String {get}

    /// A detailed description of the error in English. 
    ///
    /// **Default implementation provided.**
    ///
    /// - Important: there's a 1-1 relation between this and `errorID`.
    var devFriendlyDescription: String {get}

    /// A short identifier of the error that may be displayed to the user.
    /// This error ID should be unique across server, web client, native client.
    ///
    /// **Default implementation provided.**
    ///
    /// This MUST include the `domain` string + a `code` unique to the domain.
    /// This combination will help in identifying the underlying cause of a
    /// problem reported by a user.
    var errorID: String {get}
}

// MARK: - Default Implementations

public extension FriendlyError {
    /// Default implementation.
    ///
    /// This default implementation provides, in order:
    /// 1. The localized message to the user;
    /// 2. `The errorID` that will help identify/debug the error.
    var userFriendlyDescription: String {
        "\(userFriendlyMessage) [\(errorID)]"
    }

    /// Default implementation.
    ///
    /// This default implementation provides, in order:
    /// 1. The type of the error
    /// 2. String interpolation of `self` (doesn't seem to include the type,
    ///    but it does include interpolation of nested errors, if present)
    /// 3. `The errorID`
    /// 4. The system `localizedDescription` of the error. This is sometimes
    /// redundant but it's provided as additional context.
    var devFriendlyDescription: String {
        "[\(type(of: self)): \(self)] (\(errorID)) \(localizedDescription)"
    }

    /// Default implementation.
    ///
    /// This default implementation provides the error `domain` and `code`.
    var errorID: String {
        "\(domain): \(code)"
    }
}
