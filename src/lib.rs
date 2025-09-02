#[no_mangle]
pub unsafe extern "C" fn repro() {
    let rt = tokio::runtime::Builder::new_current_thread()
        .build()
        .unwrap();
    rt.block_on(connect());
}

async fn connect() {
    let h = spawns::spawn(async move {
        println!("async spawn");
    });
    h.await.unwrap();
}
