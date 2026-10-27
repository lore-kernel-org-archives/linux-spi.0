Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793070246;
	b=dQemRWupSXD6u1HsszM0ce2Dty+y2vxe+3g5SbRM059SwqXxDikPbfVpl6ALC1m/juPt
	 b8EDK3EgNkl9JyF+vTasvN6ABnXlkfzPzd+BrlqL5/nQadqQO8ThJUp2e71LuyiF5quet
	 Rjb8s1iV4X31lu6aiIxvHheeJmjtBqQWUfBd93b7U35+JTOpTia5RAOg/ciobzkQ+kVEp
	 oXCGbQgxhr9VjKsMj46uw30Y3/jA+w0FbQpsu941bThGyKjTM5eeTyFnpnTjN9FA21Vy9
	 evNTGhs35JM+jRad61T8Zvjbsp/mL1KYXlosxNxXR/kQP3p6SAeNuMwZotIWPPXh7nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793070246;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3YitmjyyGYwg9+ruCrgZIJozcKZ/jbbm9BPfMGJnZCk=;
	b=shIYLvd7Ru2dkXFnjLnw4HhwS8vTyAGA/CKpuScDyPgK7J+9pT3V3lHBs4a3XS2bcUGW
	 OcWKTmzaOO6eqWgiJAqRoAEH4/sUhz4ax31YJwsUN7eGpsLz7n7BR2uZ3JkgWh43DN6wU
	 s6mwLHCHkQWGPcrxpxZIr0xGZsGeeq1ooOel0sHL3J2JYMOBaEBK0WeZigV2wOEBWsG09
	 GHHanxe4sM2CclyUA2Z1pX36iiiuU/AthrC2wAOK5nlia4tAehF0HD5xx49VkJKtXymNp
	 i4nfgT+qhLjWTbrnFFPekeb5aLvkAIaQZmRIYH3HWUBv0mnh+PkU8VoYMix/u8PeVSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=gTu3C0eq;
	arc=none smtp.remote-ip=203.205.221.236
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0BD606A31B;
	Tue, 27 Oct 2026 03:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA0BD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=gTu3C0eq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793070237; bh=3YitmjyyGYwg9+ruCrgZIJozcKZ/jbbm9BPfMGJnZCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gTu3C0eqKVxnGEUnz3F5EDSlQDkhJuNhXlZZUwucg8w02pGIvfpvo2UA2idubcLgb
	 tXfvacn1whS1VaJY+KvowHdN8g6NGhdW4KblQt4sGP6/9MANzQ8DsOfQQwommaGP97
	 PprXzRnpS3ULnOlVj5NK1qY5VaVwQi9TBfM89DbM=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id F43C6C8; Tue, 27 Oct 2026 11:03:52 +0800
X-QQ-mid: xmsmtpt1793070235tnfw2g77u
Message-ID: <tencent_66EE264CDD33A4355946E42D9ACA7019C409@qq.com>
X-QQ-XMAILINFO: Nvb7z5mI5731EKflDbxB2V5ES5nxrJ+8pwsiq7dhAF4QxltFjUGTV7IRtyZsES
	 Ds9gdyAAG++2Ox6FKqidqHZ3lbZxLPvOyiIeTx+0pGOfXTXzAG+cOrSU/zr9Id0A3zhb05RAIueu
	 bqh03aO9pLPF83l10bXKRCdAWPoK53+d05qGU8DR2H2hEZioyOOUblI9Jr7SbDgqJ1DXR6Jjvs6V
	 TSzkmZ4LM+vKv4JX0iZ5W365MUHCz6uLJcdOTEmAlikuvIPO/0OoZ0tK9lpyJ/PsQgWQEreH8bTE
	 +dU+NzdfSScG1BL+1hK42aF+FIilJdyp7+yn3F4SEcwiXDCDozR8iAdGkpHRIElu7PhHb3MTuGOV
	 NlTSXvUvTC6sUeawVLwzuAKqIL6gOGxVTSxaJnkdTeOejFgcNufpqiA/i1/BkQn9It7fu5HhdZf2
	 e2S/N+k71T8ZL1/AfBpcxX1pax1ZCKjCGXZRkdFNH8OYqsqcGjAjv5/K4ANxO+CZYxJUFaebX5Ij
	 nEGLTB6pU0NfZc09BwKfLzTgjYvLxa5wsfOiqIgbS6sh/Cg/xsxf3L5C7j4B4odtVHALifdyJxRt
	 lErNw4m4bSYw64LYlupJUywzF6MbXtrkMQd5u0Bh4fBqZr7lD6zSv/0MzSjz6J8dR77j9b68LA3q
	 JCIrzB0/JIfO27sjMP57+loi8GxMpV2V7HVVhZkr9GmP2Q8Nu7kjnyxVEBksd6P0MTAkgJ4eKvWx
	 70xtX+IRxICQCMrifs9XyZa7hUe4xvdYqqwnySa6cV8d0T4veWPVf2VhV6QyaTonH9aMuvwXmLxr
	 UivbBC3lHgb/w84ChjHSrMqieaouoJzHRJGoXppkcU/ehmBgppSNGJiAXdidOurPF5fKaTEsa1/+
	 P/TpDBT9M6I6rFR/2VYep8/3i8wbZim3hzW/uU9vEQnqngojH6gd42Lgl1OZ8d0T5+Io/TYTrKL3
	 YACpuocPQiCxOejM1CNs0/E1bFBGnDxXVG8Kj1tIeuOgllIDe9YG2uvbgy5rfwjIgM8DrTv0irYd
	 7bP79K568ImWMziJL8VR75+IQw80GiFjiKfNSV3kxVgDQ4kIQ9sd5QpAL+1yfOgBGLwojpU7Icwq
	 W0pcfef3F1xVG62fc=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v5 2/3] rust: spi: add SPI driver abstractions
Date: Tue, 27 Oct 2026 11:03:51 +0800
X-OQ-MSGID: <20261027030352.615926-3-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027030352.615926-1-847807867@qq.com>
References: <20261027030352.615926-1-847807867@qq.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Rust abstractions for the SPI driver subsystem, allowing SPI
drivers to be written in Rust.

This adds the following abstractions:
- `spi::DeviceId`: a driver-side device id.
- `spi::Adapter`: the registration of SPI drivers, implementing
  `driver::DriverLayout` and `driver::RegistrationOps`.
- `spi::Driver`: the trait that SPI drivers implement, with `probe()`,
  `shutdown()` and `unbind()` callbacks.
- `spi::SpiDevice`: a representation of `struct spi_device`, providing
  device configuration accessors and the `write()`, `read()` and
  `write_then_read()` I/O operations on bound devices.
- `module_spi_driver!` and `spi_device_table!` macros.

The module is only built when CONFIG_SPI is enabled, since the SPI core
functions it uses are not available otherwise.

The device configuration accessors and the I/O operations are only
available on `SpiDevice<Bound>`: an `ARef<SpiDevice>` may outlive the
driver's unbind and the device's or controller's unregistration, and the
SPI core's transfer path does not check the registration state, so
performing I/O on an unbound device is not sound. Moreover, once the
device is unbound, another driver may bind to the same
`struct spi_device` and mutate the device configuration with plain,
non-atomic writes (e.g. via `spi_setup()`), so reading the configuration
would be a data race. Driver callbacks receive a `SpiDevice<Core>`,
which dereferences to `SpiDevice<Bound>`.

The `write()` and `read()` methods copy the data into DMA-safe bounce
buffers before transferring, as the SPI core requires transfer buffers
to be DMA-safe and the caller-provided slices may be located anywhere
(e.g. on the stack). `write_then_read()` does not need this, since the
C core's spi_write_then_read() already copies both buffers into
internal DMA-safe bounce buffers.

Match data lookup follows the same order as the C core's
spi_get_device_match_data(): first the OF/ACPI match data, then the SPI
id table. Entries without driver data (e.g. `@none` id tables) are
handled gracefully.

Signed-off-by: Shuai Liu <847807867@qq.com>
---
 rust/kernel/Kconfig.test |  11 +
 rust/kernel/lib.rs       |   2 +
 rust/kernel/spi.rs       | 563 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 576 insertions(+)
 create mode 100644 rust/kernel/spi.rs

diff --git a/rust/kernel/Kconfig.test b/rust/kernel/Kconfig.test
index 3bf4194f28c7..bda70dcc7793 100644
--- a/rust/kernel/Kconfig.test
+++ b/rust/kernel/Kconfig.test
@@ -94,6 +94,17 @@ config RUST_BUG_KUNIT_TEST
 
 	  If unsure, say N.
 
+config RUST_SPI_KUNIT_TEST
+	bool "KUnit tests for the Rust SPI driver abstractions" if !KUNIT_ALL_TESTS
+	depends on SPI=y
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables KUnit tests for the Rust SPI driver
+	  abstractions. These are only for development and testing, not
+	  for regular kernel use cases.
+
+	  If unsure, say N.
+
 config RUST_TIME_KUNIT_TEST
 	bool "KUnit tests for the Rust time API" if !KUNIT_ALL_TESTS
 	default KUNIT_ALL_TESTS
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index a4747f75b163..cbe5a4ed825d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -133,6 +133,8 @@
 pub mod sizes;
 #[cfg(CONFIG_SOC_BUS)]
 pub mod soc;
+#[cfg(CONFIG_SPI)]
+pub mod spi;
 #[doc(hidden)]
 pub mod std_vendor;
 pub mod str;
diff --git a/rust/kernel/spi.rs b/rust/kernel/spi.rs
new file mode 100644
index 000000000000..b33144bd68da
--- /dev/null
+++ b/rust/kernel/spi.rs
@@ -0,0 +1,563 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! SPI Driver subsystem
+//!
+//! This module adds abstractions for the SPI driver subsystem, allowing drivers to be
+//! written in Rust for SPI devices.
+
+// SPI Driver abstractions.
+use crate::{
+    acpi,
+    device,
+    device_id::{
+        RawDeviceId,
+        RawDeviceIdIndex, //
+    },
+    driver,
+    error::*,
+    of,
+    prelude::*,
+    sync::aref::AlwaysRefCounted,
+    types::Opaque, //
+};
+
+use core::{
+    marker::PhantomData,
+    mem::offset_of,
+    ptr::NonNull, //
+};
+
+/// An SPI device id table.
+#[repr(transparent)]
+#[derive(Clone, Copy)]
+pub struct DeviceId(bindings::spi_device_id);
+
+impl DeviceId {
+    const SPI_NAME_SIZE: usize = 32;
+
+    /// Create a new device id from an SPI 'id' string.
+    #[inline(always)]
+    pub const fn new(id: &'static CStr) -> Self {
+        let src = id.to_bytes_with_nul();
+        build_assert!(src.len() <= Self::SPI_NAME_SIZE, "ID exceeds 32 bytes");
+        let mut spi: bindings::spi_device_id = pin_init::zeroed();
+        let mut i = 0;
+        while i < src.len() {
+            spi.name[i] = src[i];
+            i += 1;
+        }
+
+        Self(spi)
+    }
+}
+
+// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `spi_device_id` and does not add
+// additional invariants, so it's safe to transmute to `RawType`.
+unsafe impl RawDeviceId for DeviceId {
+    type RawType = bindings::spi_device_id;
+}
+
+// SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
+unsafe impl RawDeviceIdIndex for DeviceId {
+    const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::spi_device_id, driver_data);
+}
+
+/// IdTable type for SPI
+pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
+
+/// Create a SPI `IdTable` with its alias for modpost.
+#[macro_export]
+macro_rules! spi_device_table {
+    ($($tt:tt)*) => {
+        $crate::module_device_table!("spi", $crate::spi::DeviceId, $($tt)*);
+    };
+}
+
+/// An adapter for the registration of SPI drivers.
+pub struct Adapter<T: Driver>(T);
+
+// SAFETY:
+// - `bindings::spi_driver` is a C type declared as `repr(C)`.
+// - `T::Data` is the type of the driver's device private data.
+// - `struct spi_driver` embeds a `struct device_driver`.
+// - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
+unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
+    type DriverType = bindings::spi_driver;
+    type DriverData<'bound> = T::Data<'bound>;
+    const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
+}
+
+// SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
+// a preceding call to `register` has been successful.
+unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
+    unsafe fn register(
+        sdrv: &Opaque<Self::DriverType>,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        build_assert!(
+            T::ACPI_ID_TABLE.is_some() || T::OF_ID_TABLE.is_some() || T::SPI_ID_TABLE.is_some(),
+            "At least one of ACPI/OF/Legacy tables must be present when registering an spi driver"
+        );
+
+        let spi_table = match T::SPI_ID_TABLE {
+            Some(table) => table.as_ptr(),
+            None => core::ptr::null(),
+        };
+
+        let of_table = match T::OF_ID_TABLE {
+            Some(table) => table.as_ptr(),
+            None => core::ptr::null(),
+        };
+
+        let acpi_table = match T::ACPI_ID_TABLE {
+            Some(table) => table.as_ptr(),
+            None => core::ptr::null(),
+        };
+
+        // SAFETY: It's safe to set the fields of `struct spi_driver` on initialization.
+        unsafe {
+            (*sdrv.get()).driver.name = name.as_char_ptr();
+            (*sdrv.get()).probe = Some(Self::probe_callback);
+            (*sdrv.get()).remove = Some(Self::remove_callback);
+            (*sdrv.get()).shutdown = Some(Self::shutdown_callback);
+            (*sdrv.get()).id_table = spi_table;
+            (*sdrv.get()).driver.of_match_table = of_table;
+            (*sdrv.get()).driver.acpi_match_table = acpi_table;
+        }
+
+        // SAFETY: `sdrv` is guaranteed to be a valid `DriverType`.
+        to_result(unsafe { bindings::__spi_register_driver(module.as_ptr(), sdrv.get()) })
+    }
+
+    unsafe fn unregister(sdrv: &Opaque<Self::DriverType>) {
+        // SAFETY: `sdrv` is guaranteed to be a valid `DriverType`.
+        unsafe { bindings::spi_unregister_driver(sdrv.get()) }
+    }
+}
+
+impl<T: Driver> Adapter<T> {
+    extern "C" fn probe_callback(sdev: *mut bindings::spi_device) -> kernel::ffi::c_int {
+        // SAFETY: The SPI bus only ever calls the probe callback with a valid pointer to a
+        // `struct spi_device`.
+        //
+        // INVARIANT: `sdev` is valid for the duration of `probe_callback()`.
+        let sdev = unsafe { &*sdev.cast::<SpiDevice<device::CoreInternal<'_>>>() };
+
+        // Match the lookup order of the C core's `spi_get_device_match_data()`: first the
+        // OF/ACPI match data, then the SPI id table.
+        //
+        // SAFETY: `sdev` matched data is of type `Self::IdInfo`.
+        let info = unsafe { <Self as driver::Adapter>::id_info(sdev.as_ref()) }
+            .or_else(|| Self::spi_id_info(sdev));
+
+        from_result(|| {
+            let data = T::probe(sdev, info);
+
+            sdev.as_ref().set_drvdata(data)?;
+            Ok(0)
+        })
+    }
+
+    extern "C" fn remove_callback(sdev: *mut bindings::spi_device) {
+        // SAFETY: `sdev` is a valid pointer to a `struct spi_device`.
+        let sdev = unsafe { &*sdev.cast::<SpiDevice<device::CoreInternal<'_>>>() };
+
+        // SAFETY: `remove_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `SpiDevice::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T::Data<'_>>>`.
+        let data = unsafe { sdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
+
+        T::unbind(sdev, data);
+    }
+
+    extern "C" fn shutdown_callback(sdev: *mut bindings::spi_device) {
+        // SAFETY: `shutdown_callback` is only ever called for a valid `sdev`
+        let sdev = unsafe { &*sdev.cast::<SpiDevice<device::CoreInternal<'_>>>() };
+
+        // SAFETY: `shutdown_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `SpiDevice::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T::Data<'_>>>`.
+        let data = unsafe { sdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
+
+        T::shutdown(sdev, data);
+    }
+
+    /// Returns the driver's private data from the matching entry in the [`spi::IdTable`], if any.
+    ///
+    /// If this returns `None`, it means there is no match with an entry in the [`spi::IdTable`].
+    fn spi_id_info(dev: &SpiDevice) -> Option<&'static <Self as driver::Adapter>::IdInfo> {
+        // Ensure the driver has an SPI id table: the entries matched by `spi_get_device_id()`
+        // below come from the table registered in `register()`, i.e. `T::SPI_ID_TABLE`, which
+        // guarantees that every `driver_data` field is a valid `T::IdInfo`.
+        T::SPI_ID_TABLE.as_ref()?;
+
+        // SAFETY:
+        // - `dev` is guaranteed to be valid while it's alive, and so is `dev.as_raw()`.
+        //
+        // `spi_get_device_id()` looks up the registered driver id table using the device's
+        // modalias and returns either a pointer to a matching entry or `NULL`.
+        let raw_id = unsafe { bindings::spi_get_device_id(dev.as_raw()) };
+
+        if raw_id.is_null() {
+            return None;
+        }
+
+        // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct spi_device_id` and
+        // does not add additional invariants, so it's safe to transmute.
+        let id = unsafe { &*raw_id.cast::<DeviceId>() };
+
+        // SAFETY: `id` comes from the driver's id table (as established by the `T::SPI_ID_TABLE`
+        // check above). By the safety requirements of `info_unchecked_opt()`, this is either a
+        // valid `T::IdInfo` or `NULL` (e.g. for a `@none` table), which `info_unchecked_opt()`
+        // handles by returning `None`.
+        unsafe { id.info_unchecked_opt::<T::IdInfo>() }
+    }
+}
+
+impl<T: Driver> driver::Adapter for Adapter<T> {
+    type IdInfo = T::IdInfo;
+
+    fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
+        T::OF_ID_TABLE
+    }
+
+    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
+        T::ACPI_ID_TABLE
+    }
+}
+
+/// Declares a kernel module that exposes a single spi driver.
+///
+/// # Examples
+///
+/// ```ignore
+/// kernel::module_spi_driver! {
+///     type: MyDriver,
+///     name: "Module name",
+///     authors: ["Author name"],
+///     description: "Description",
+///     license: "GPL v2",
+/// }
+/// ```
+#[macro_export]
+macro_rules! module_spi_driver {
+    ($($f:tt)*) => {
+        $crate::module_driver!(<T>, $crate::spi::Adapter<T>, { $($f)* });
+    };
+}
+
+/// The spi driver trait.
+///
+/// Drivers must implement this trait in order to get a spi driver registered.
+///
+/// # Example
+///
+///```
+/// # use kernel::{device::Core, spi, of};
+///
+/// struct MyDriver;
+///
+/// kernel::spi_device_table!(
+///     SPI_TABLE,
+///     <MyDriver as spi::Driver>::IdInfo,
+///     [
+///          (spi::DeviceId::new(c"rust_driver_spi"), ())
+///     ]
+/// );
+///
+/// kernel::of_device_table!(
+///     OF_TABLE,
+///     <MyDriver as spi::Driver>::IdInfo,
+///     [
+///         (of::DeviceId::new(c"test,device"), ())
+///     ]
+/// );
+///
+/// impl spi::Driver for MyDriver {
+///     type IdInfo = ();
+///     type Data<'bound> = Self;
+///     const SPI_ID_TABLE: Option<spi::IdTable<Self::IdInfo>> = Some(&SPI_TABLE);
+///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+///
+///     fn probe<'bound>(
+///         _sdev: &'bound spi::SpiDevice<Core<'_>>,
+///         _id_info: Option<&'bound Self::IdInfo>,
+///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+///         Err(ENODEV)
+///     }
+///
+///     fn shutdown<'bound>(
+///         _sdev: &'bound spi::SpiDevice<Core<'_>>,
+///         this: Pin<&Self::Data<'bound>>,
+///     ) {
+///     }
+/// }
+///```
+pub trait Driver {
+    /// The type holding information about each device id supported by the driver.
+    // TODO: Use `associated_type_defaults` once stabilized:
+    //
+    // ```
+    // type IdInfo: 'static = ();
+    // ```
+    type IdInfo: 'static;
+
+    /// The type of the driver's bus device private data.
+    type Data<'bound>: Send + 'bound;
+
+    /// The table of device ids supported by the driver.
+    const SPI_ID_TABLE: Option<IdTable<Self::IdInfo>> = None;
+
+    /// The table of OF device ids supported by the driver.
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
+
+    /// The table of ACPI device ids supported by the driver.
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
+
+    /// SPI driver probe.
+    ///
+    /// Called when a new spi device is added or discovered.
+    /// Implementers should attempt to initialize the device here.
+    fn probe<'bound>(
+        dev: &'bound SpiDevice<device::Core<'_>>,
+        id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
+
+    /// SPI driver shutdown.
+    ///
+    /// Called by the kernel during system reboot or power-off to allow the [`Driver`] to bring the
+    /// [`SpiDevice`] into a safe state. Implementing this callback is optional.
+    ///
+    /// Typical actions include stopping transfers, disabling interrupts, or resetting the hardware
+    /// to prevent undesired behavior during shutdown.
+    ///
+    /// This callback is distinct from final resource cleanup, as the driver instance remains valid
+    /// after it returns. Any deallocation or teardown of driver-owned resources should instead be
+    /// handled in `Drop`.
+    fn shutdown<'bound>(dev: &'bound SpiDevice<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
+        let _ = (dev, this);
+    }
+
+    /// SPI driver unbind.
+    ///
+    /// Called when the [`SpiDevice`] is unbound from its bound [`Driver`]. Implementing this
+    /// callback is optional.
+    ///
+    /// This callback serves as a place for drivers to perform teardown operations that require a
+    /// `&Device<Core>` or `&Device<Bound>` reference. For instance, drivers may try to perform I/O
+    /// operations to gracefully tear down the device.
+    ///
+    /// Otherwise, release operations for driver resources should be performed in `Drop`.
+    fn unbind<'bound>(dev: &'bound SpiDevice<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
+        let _ = (dev, this);
+    }
+}
+
+/// The spi device representation.
+///
+/// This structure represents the Rust abstraction for a C `struct spi_device`. The
+/// implementation abstracts the usage of an existing C `struct spi_device` that
+/// gets passed from the C side.
+///
+/// # Invariants
+///
+/// A [`SpiDevice`] instance represents a valid `struct spi_device` created by the C portion of
+/// the kernel.
+#[repr(transparent)]
+pub struct SpiDevice<Ctx: device::DeviceContext = device::Normal>(
+    Opaque<bindings::spi_device>,
+    PhantomData<Ctx>,
+);
+
+impl<Ctx: device::DeviceContext> SpiDevice<Ctx> {
+    fn as_raw(&self) -> *mut bindings::spi_device {
+        self.0.get()
+    }
+}
+
+/// Device configuration accessors and I/O operations, restricted to bound devices.
+///
+/// An `ARef<SpiDevice>` (i.e. a `SpiDevice<Normal>`) may outlive the driver's unbind and the
+/// device's or controller's unregistration. The SPI core's transfer path does not check the
+/// registration state, and the controller driver's resources (e.g. `spi->controller_state` or
+/// MMIO mappings) may already have been released, so performing I/O on an unbound device is not
+/// sound. Likewise, once the device is unbound, another driver may bind to the same
+/// `struct spi_device` and mutate the device configuration with plain, non-atomic writes (e.g.
+/// via `spi_setup()`), so reading the configuration accessors on an unbound device would be a
+/// data race. Restricting these operations to [`SpiDevice<Bound>`] guarantees that the device is
+/// still bound to a driver; driver callbacks receive a `SpiDevice<Core>`, which dereferences to
+/// `SpiDevice<Bound>`.
+impl SpiDevice<device::Bound> {
+    /// Returns the maximum speed of the SPI device.
+    #[inline]
+    pub fn max_speed_hz(&self) -> u32 {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a valid pointer to a
+        // `struct spi_device`.
+        unsafe { (*self.as_raw()).max_speed_hz }
+    }
+
+    /// Returns the number of bits per word of the SPI device.
+    #[inline]
+    pub fn bits_per_word(&self) -> u8 {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a valid pointer to a
+        // `struct spi_device`.
+        unsafe { (*self.as_raw()).bits_per_word }
+    }
+
+    /// Returns the mode flags of the SPI device.
+    #[inline]
+    pub fn mode(&self) -> u32 {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a valid pointer to a
+        // `struct spi_device`.
+        unsafe { (*self.as_raw()).mode }
+    }
+
+    /// Writes the data from `buf` to the SPI device.
+    ///
+    /// The data is copied into a DMA-safe bounce buffer before the transfer, since the
+    /// slice may be located anywhere (e.g. on the stack).
+    #[inline]
+    pub fn write(&self, buf: &[u8]) -> Result {
+        let mut bounce = KVec::with_capacity(buf.len(), GFP_KERNEL)?;
+        bounce.extend_from_slice(buf, GFP_KERNEL)?;
+
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a valid pointer to a
+        // `struct spi_device`. `bounce` is valid for reads of length `bounce.len()` for the
+        // duration of the call, which SPI core guarantees not to outlive.
+        to_result(unsafe {
+            bindings::spi_write(self.as_raw(), bounce.as_ptr().cast(), bounce.len())
+        })
+    }
+
+    /// Reads data from the SPI device into `buf`.
+    ///
+    /// The received data is collected in a DMA-safe bounce buffer and then copied into
+    /// `buf`, since the slice may be located anywhere (e.g. on the stack).
+    #[inline]
+    pub fn read(&self, buf: &mut [u8]) -> Result {
+        let mut bounce = KVec::with_capacity(buf.len(), GFP_KERNEL)?;
+        bounce.resize(buf.len(), 0, GFP_KERNEL)?;
+
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a valid pointer to a
+        // `struct spi_device`. `bounce` is valid for writes of length `bounce.len()` for
+        // the duration of the call, which SPI core guarantees not to outlive.
+        to_result(unsafe {
+            bindings::spi_read(self.as_raw(), bounce.as_mut_ptr().cast(), bounce.len())
+        })?;
+
+        buf.copy_from_slice(&bounce);
+        Ok(())
+    }
+
+    /// Writes the data from `write_buf` to the SPI device, then reads data from the SPI device
+    /// into `read_buf`.
+    ///
+    /// The buffers don't need to be DMA-safe: the SPI core copies them into internal
+    /// DMA-safe bounce buffers.
+    #[inline]
+    pub fn write_then_read(&self, write_buf: &[u8], read_buf: &mut [u8]) -> Result {
+        let n_tx = u32::try_from(write_buf.len())?;
+        let n_rx = u32::try_from(read_buf.len())?;
+
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a valid pointer to a
+        // `struct spi_device`. `write_buf` is valid for reads of length `n_tx` and `read_buf`
+        // is valid for writes of length `n_rx` for the duration of the call, which SPI core
+        // guarantees not to outlive.
+        to_result(unsafe {
+            bindings::spi_write_then_read(
+                self.as_raw(),
+                write_buf.as_ptr().cast(),
+                n_tx,
+                read_buf.as_mut_ptr().cast(),
+                n_rx,
+            )
+        })
+    }
+}
+
+// SAFETY: `SpiDevice` is a transparent wrapper of `struct spi_device`.
+// The offset is guaranteed to point to a valid device field inside `SpiDevice`.
+unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for SpiDevice<Ctx> {
+    const OFFSET: usize = offset_of!(bindings::spi_device, dev);
+}
+
+// SAFETY: `SpiDevice` is a transparent wrapper of a type that doesn't depend on
+// `SpiDevice`'s generic argument.
+kernel::impl_device_context_deref!(unsafe { SpiDevice });
+kernel::impl_device_context_into_aref!(SpiDevice);
+
+// SAFETY: Instances of `SpiDevice` are always reference-counted.
+unsafe impl AlwaysRefCounted for SpiDevice {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::get_device(self.as_ref().as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).dev) }
+    }
+}
+
+impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for SpiDevice<Ctx> {
+    fn as_ref(&self) -> &device::Device<Ctx> {
+        let raw = self.as_raw();
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct spi_device`.
+        let dev = unsafe { &raw mut (*raw).dev };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { device::Device::from_raw(dev) }
+    }
+}
+
+// SAFETY: A `SpiDevice` is always reference-counted and can be released from any thread.
+unsafe impl Send for SpiDevice {}
+
+// SAFETY: `SpiDevice` can be shared among threads because `SpiDevice<Normal>` has no methods
+// that could mutate the device state or race with the C core (the configuration accessors and
+// I/O operations are restricted to `SpiDevice<Bound>`).
+unsafe impl Sync for SpiDevice {}
+
+// SAFETY: Same as `SpiDevice<Normal>` -- the underlying `struct spi_device` is the same;
+// `Bound` is a zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for SpiDevice<device::Bound> {}
+
+#[cfg(CONFIG_RUST_SPI_KUNIT_TEST)]
+#[kunit_tests(rust_kernel_spi)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn device_id_name_size() {
+        assert_eq!(DeviceId::SPI_NAME_SIZE, bindings::SPI_NAME_SIZE as usize);
+    }
+
+    #[test]
+    fn device_id_new_short_name() {
+        let id = DeviceId::new(c"rust_driver_spi");
+
+        let expected: &[u8] = b"rust_driver_spi\0";
+        assert_eq!(&id.0.name[..expected.len()], expected);
+
+        // The remaining bytes must be zeroed.
+        assert!(id.0.name[expected.len()..].iter().all(|&byte| byte == 0));
+    }
+
+    #[test]
+    fn device_id_new_empty_name() {
+        let id = DeviceId::new(c"");
+
+        assert!(id.0.name.iter().all(|&byte| byte == 0));
+    }
+
+    #[test]
+    fn device_id_new_max_length_name() {
+        // 31 bytes plus the NUL terminator is the maximum accepted name length.
+        let id = DeviceId::new(c"abcdefghijklmnopqrstuvwxyz01234");
+
+        let expected: &[u8] = b"abcdefghijklmnopqrstuvwxyz01234\0";
+        assert_eq!(&id.0.name[..], expected);
+    }
+}
-- 
2.43.0

