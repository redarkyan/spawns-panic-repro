#[no_mangle]
pub unsafe extern "C" fn v1_repro() {
    let rt = tokio::runtime::Builder::new_current_thread()
        .enable_all()
        .build()
        .unwrap();
    let _guard = rt.enter();
    rt.block_on(connect());
}

async fn connect() {
    let h = spawns::spawn(async move {
        println!("async spawn from v1");
    });
    h.await.unwrap();
}
