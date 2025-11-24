module hello_object::hello_object {

    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::event;
    use sui::string;

    /// This is the object that will be created on chain
    struct HelloObject has key {
        id: UID,
        message: string::String,
    }

    /// Event emitted when the object is created
    struct HelloCreatedEvent has drop, store {
        message: string::String,
    }

    /// entry function: anyone can call this to create a Hello object
    public entry fun create_hello(message: string::String, ctx: &mut TxContext) {
        // Create object
        let obj = HelloObject {
            id: object::new(ctx),
            message,
        };

        // Emit event (so you can SEE the result)
        event::emit(HelloCreatedEvent { message: obj.message.clone() });

        // Return object to caller
        object::share_object(obj);
    }
}
