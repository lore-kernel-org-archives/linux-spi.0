Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618478;
	b=Htg5QisTC8vNPHDzr58gbJDuS9f8rzkWB28c1lbTZFQzvdPWNyXU035RC+oBVJO3S+/c
	 cMdfiZgiv7EhVOLBfMbCeWfz63a75umP0e0KSfydIGfduF5XWXybJwEIR3iFR5zASmcqB
	 DV9o8izY8+xbk8wG34VlFi4ciGl1NXWZhUe/xKrRnTkSD+HPfY79b6ss0VCRod8cmL3OB
	 nHI9RY10GfQAD7+davD1l+guNnyWObXjoyk+GUyBWepdC+rpkskwpV/MKCoQIextX0rny
	 m+A5NKL/8zySMEdT+HpJXvNemYGt9FPfmtNTD2o+CnxmxDgREbiPw8m75Qhf93TuOow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618478;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e211hEpA0PYxOoUBK4KJXg+S1N2EV1cw+67fe1q5EVM=;
	b=5F7nzcSAfS16cJklq3wYdXmduPtxekpedSdWSSXIWMGZwMH6bafDl0+uq6iTi/8DNGJ0
	 4uWIB9DnkDJabXJSHzRaii6LucSI2H1M34SdKwoJ1C0xacLf64jycFhBFeXlKTD+QjvpN
	 gMi2/04sBZ+lS2rd12lb9me05iRWuglzKhmPI7CYAYmqq0s/o8XaoP32RPY1MqygG4G3T
	 TfBya7Zz0phwazSLh85YOut5CewZzv0xUSqcO6fb7mcHEelkpRi8tThrxd3uuZaANjWJ6
	 GsZjkBEvyJgmYimxsf7t5ugz9qKReAIEdd8qgpO8e8gd4E/MkgzUieLrUmimUnapklg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=lNBcIurm;
	arc=none smtp.remote-ip=203.205.221.164
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E71606A336;
	Sat, 14 Nov 2026 01:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91E71606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=lNBcIurm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794618469; bh=e211hEpA0PYxOoUBK4KJXg+S1N2EV1cw+67fe1q5EVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lNBcIurmcHgHIy+Dw99AfbPA2bTRnBMnjMIJ9xE0HAbtJQPmiHUPJgnzUgNQB+HqX
	 0gJGRDUnvTHbW4BsxTyYMaC2++RO2r4Pow/EvzLHoIMAQ4PWeIUsG+I6qly3T20OWt
	 pZ2eNb2OQmCnRgJyy2ftSYkzF+msPdauk9fEMwnM=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.198])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 1EE0C051; Sat, 14 Nov 2026 09:07:46 +0800
X-QQ-mid: xmsmtpt1794618467tjrwlgeur
Message-ID: <tencent_9EE5F19BC870FDC4DC279ADD67A4B358AC09@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznpOej/1j548oeNmsgoEYV/opixCNocghGyIUM1jxdKAtC8EpHXa
	 WDJbAVjDjoQukqCilE8RnwaHZEL0q30cxxs6HOxaNMRoxXUcINpeXq5mPbdZmA+8xvlhVeIxDMau
	 xfW2gVndF0g2HkDscYeGEI7kzo1/PmSsXRb4VrLVW6gbheWV/LIoYMMrMsiqu+Sn8/Zz8Gsw6qBQ
	 8jEM8ey3Xwqoli/EozXZV3+PAi9HYNYC+uIVQy+SxqsTJaWU/f12NlOm6c5PN64Pph/DngZRpHe6
	 Z2+U3EqM9lh0PbQGDV0+aUCmUU1LXxQYJPDkB+gdcKESwqCcNBQ7G9Ib5LKzwUF5FCBE12AxZk0W
	 29JAgrW4VukJWKjAD+1YA8lmnf3nMhYk1qDzvQNEvfgURT3s4goAkUQt/mk/HXsyaQFUMueR+5Tt
	 r05wL9cgZmRleGwzTCv3lNPcGxB6mvAArRhXAAA4bEpjm5abJtlLT1tsAuFg/xwPvb5h3ph9kf61
	 QHQhBCmiFQeOg4An0tzxCQr3FChgnJHhgnq0McehG8rEPRP0iv348nXt2J2ar12HLcsDDUO/O/fO
	 bHHvXLBLxnjkfyyEn1PAysSFINZyc1jFM4OS15qBueTWLH5RDcHsxHgcV+qNlfU6Q0rixa/ghoA6
	 KeFIVDT3twcUFshZEGG6UFEWBr4wwSw8MdS6Lmmkfk8b4PS9Q8QkkG3o7UlAb9iIGwWhhOPPc6IM
	 wK2frEpy+xWSGVFY0X0mR3EaozUHotjO0pt4RctUnCw+9bnEs7sJLfBNvzYGdRJbx57DLySij9yt
	 jGENY6kpBXxB8hd8uyUK6e51h1Bc4fRaqD3WL0nDYcn9m2B7Uk3RaCYfkOBNBHHnvdQhfhbRDjga
	 TXhQ3xrI7wrPgFKpqJjH1pyY6U9sNYaIWGcoHaxjK9Y2crYNrC6LxkC9bpIDaqUhdj2IYyC7LKB6
	 evaCGcnMlYnWtzx2P8lizNPQixUeyZHWilDQ1DBQSMiYpKArPiXRAfXMyKMEISJtCJcVxfWlQvmr
	 zxl7Fr1QfzvbLpLWoeFI9o9btE0AQ2xiSgv9uM0m2YpxWKSegKDmsasFAH3avD/uaK0gBFKv7Yhc
	 Q/9ZZjbYZZXJY7gzFdpV7pb0INNQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	847807867@qq.com
Subject: [PATCH v8 2/3] rust: spi: add SPI driver abstractions
Date: Sat, 14 Nov 2026 09:07:44 +0800
X-OQ-MSGID: <20261114010745.82389-2-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114010745.82389-1-847807867@qq.com>
References: <tencent_5FBF490F375F4C66A2C8DD421A8E8542FE05@qq.com>
 <20261114010745.82389-1-847807867@qq.com>
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
  device configuration accessors and device I/O on bound devices.
- `spi::Transfer`: a single SPI transfer that transmits, receives, or
  does both simultaneously (full duplex).
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

Device I/O is built on a single primitive, `SpiDevice::transfer()`,
which maps to the C `spi_sync()` API: a sequence of `Transfer`s is
submitted as one `spi_message`, executed in order with the chip select
asserted for the whole message. The convenience methods `write()`,
`read()` and `write_then_read()` are thin wrappers on top of it.

`spi_sync()` requires transfer buffers to be DMA-safe, and Rust slices
may be located anywhere (e.g. on the stack), so `transfer()` copies all
data into DMA-safe bounce buffers before submitting the message and
copies received data back afterwards. Unlike the previous approach of
leveraging the C convenience wrappers, this maps directly onto the
lower-level C APIs and also supports full-duplex transfers, which the C
convenience wrappers do not offer.

Match data lookup follows the same order as the C core's
spi_get_device_match_data(): first the OF/ACPI match data, then the SPI
id table. Entries without driver data (e.g. `@none` id tables) are
handled gracefully.

Signed-off-by: Shuai Liu <847807867@qq.com>

Link: https://lore.kernel.org/rust-for-linux/179451185979.339049.12323339081307899766.b4-review@b4/
---
 rust/kernel/Kconfig.test |  11 +
 rust/kernel/lib.rs       |   2 +
 rust/kernel/spi.rs       | 673 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 686 insertions(+)
 create mode 100644 rust/kernel/spi.rs

diff --git a/rust/kernel/Kconfig.test b/rust/kernel/Kconfig.test
index d198ea0d136c9..0bcc653bb821b 100644
--- a/rust/kernel/Kconfig.test
+++ b/rust/kernel/Kconfig.test
@@ -105,6 +105,17 @@ config RUST_BUG_KUNIT_TEST
 
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
index 0d5e9f5fd3cb2..a169445b41403 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -139,6 +139,8 @@
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
index 0000000000000..424563baddb3e
--- /dev/null
+++ b/rust/kernel/spi.rs
@@ -0,0 +1,673 @@
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
+/// A single SPI transfer.
+///
+/// A transfer transmits, receives, or transmits and receives simultaneously (full duplex).
+/// A sequence of transfers is submitted to the device as a single message with
+/// [`SpiDevice::transfer`].
+///
+/// The buffers don't need to be DMA-safe: the data is copied into DMA-safe bounce buffers
+/// internally, since Rust slices may be located anywhere (e.g. on the stack).
+pub struct Transfer<'buf> {
+    tx: Option<&'buf [u8]>,
+    rx: Option<&'buf mut [u8]>,
+}
+
+impl<'buf> Transfer<'buf> {
+    /// Creates a transfer that transmits the data in `tx`.
+    pub fn write(tx: &'buf [u8]) -> Self {
+        Self {
+            tx: Some(tx),
+            rx: None,
+        }
+    }
+
+    /// Creates a transfer that receives data into `rx`.
+    pub fn read(rx: &'buf mut [u8]) -> Self {
+        Self {
+            tx: None,
+            rx: Some(rx),
+        }
+    }
+
+    /// Creates a full-duplex transfer: `tx` is transmitted while `rx` is received
+    /// simultaneously.
+    ///
+    /// The two buffers must have the same length. Controllers with the
+    /// `SPI_CONTROLLER_HALF_DUPLEX` flag (or devices in 3-wire mode) reject full-duplex
+    /// transfers with [`EINVAL`].
+    pub fn full_duplex(tx: &'buf [u8], rx: &'buf mut [u8]) -> Self {
+        Self {
+            tx: Some(tx),
+            rx: Some(rx),
+        }
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
+    /// Executes a sequence of [`Transfer`]s as a single SPI message.
+    ///
+    /// This is the primitive that all I/O methods are built on; it maps to the C `spi_sync()`
+    /// API. The transfers are executed in order with the chip select asserted for the whole
+    /// message.
+    ///
+    /// # Examples
+    ///
+    /// ```ignore
+    /// use kernel::spi::{self, Transfer};
+    ///
+    /// fn read_register(dev: &spi::SpiDevice<kernel::device::Bound>, reg: u8) -> Result<u8> {
+    ///     let cmd = [reg];
+    ///     let mut val = [0u8; 1];
+    ///     dev.transfer(&mut [Transfer::write(&cmd), Transfer::read(&mut val)])?;
+    ///     Ok(val[0])
+    /// }
+    /// ```
+    pub fn transfer(&self, transfers: &mut [Transfer<'_>]) -> Result {
+        if transfers.is_empty() {
+            return Err(EINVAL);
+        }
+
+        struct Bounce {
+            tx: KVec<u8>,
+            rx: KVec<u8>,
+        }
+
+        // `spi_sync()` requires transfer buffers to be DMA-safe, but Rust slices may be
+        // located anywhere (e.g. on the stack), so the data is copied into DMA-safe bounce
+        // buffers.
+        let mut bounces: KVec<Bounce> = KVec::with_capacity(transfers.len(), GFP_KERNEL)?;
+        let mut xfers: KVec<bindings::spi_transfer> =
+            KVec::with_capacity(transfers.len(), GFP_KERNEL)?;
+
+        for t in transfers.iter() {
+            if let (Some(tx), Some(rx)) = (&t.tx, &t.rx) {
+                if tx.len() != rx.len() {
+                    return Err(EINVAL);
+                }
+            }
+
+            let tx_len = t.tx.map_or(0, |buf| buf.len());
+            let rx_len = t.rx.as_deref().map_or(0, |buf| buf.len());
+            let len = tx_len.max(rx_len);
+            if len == 0 || len > u32::MAX as usize {
+                return Err(EINVAL);
+            }
+
+            let tx = t.tx.unwrap_or(&[]);
+            let mut tx_bounce = KVec::with_capacity(tx.len(), GFP_KERNEL)?;
+            tx_bounce.extend_from_slice(tx, GFP_KERNEL)?;
+
+            let mut rx_bounce = KVec::with_capacity(rx_len, GFP_KERNEL)?;
+            rx_bounce.resize(rx_len, 0, GFP_KERNEL)?;
+
+            let xfer = bindings::spi_transfer {
+                tx_buf: if tx_bounce.is_empty() {
+                    core::ptr::null()
+                } else {
+                    tx_bounce.as_ptr().cast()
+                },
+                rx_buf: if rx_bounce.is_empty() {
+                    core::ptr::null_mut()
+                } else {
+                    rx_bounce.as_mut_ptr().cast()
+                },
+                len: len as u32,
+                ..pin_init::zeroed()
+            };
+            xfers.push(xfer, GFP_KERNEL)?;
+            bounces.push(
+                Bounce {
+                    tx: tx_bounce,
+                    rx: rx_bounce,
+                },
+                GFP_KERNEL,
+            )?;
+        }
+
+        let mut msg: bindings::spi_message = pin_init::zeroed();
+
+        // SAFETY: `msg` is a valid `struct spi_message`.
+        unsafe { bindings::spi_message_init(&mut msg) };
+
+        for xfer in xfers.iter_mut() {
+            // SAFETY: `xfer` is a valid `struct spi_transfer` and `msg` has been initialized
+            // by `spi_message_init()` above.
+            unsafe { bindings::spi_message_add_tail(xfer, &mut msg) };
+        }
+
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a valid pointer to a
+        // `struct spi_device`. `msg` and the `struct spi_transfer`s linked into it are valid
+        // for the duration of the call, and `spi_sync()` is synchronous, so they are not
+        // accessed by the C core after it returns.
+        to_result(unsafe { bindings::spi_sync(self.as_raw(), &mut msg) })?;
+
+        for (t, bounce) in transfers.iter_mut().zip(bounces.iter_mut()) {
+            if let Some(rx) = t.rx.as_deref_mut() {
+                rx.copy_from_slice(&bounce.rx);
+            }
+        }
+
+        Ok(())
+    }
+
+    /// Writes the data from `buf` to the SPI device.
+    #[inline]
+    pub fn write(&self, buf: &[u8]) -> Result {
+        self.transfer(&mut [Transfer::write(buf)])
+    }
+
+    /// Reads data from the SPI device into `buf`.
+    #[inline]
+    pub fn read(&self, buf: &mut [u8]) -> Result {
+        self.transfer(&mut [Transfer::read(buf)])
+    }
+
+    /// Writes the data from `write_buf` to the SPI device, then reads data from the SPI device
+    /// into `read_buf`, with the chip select asserted for the whole operation.
+    ///
+    /// This performs the two phases sequentially; to transmit and receive simultaneously, use
+    /// [`Transfer::full_duplex`] with [`SpiDevice::transfer`].
+    #[inline]
+    pub fn write_then_read(&self, write_buf: &[u8], read_buf: &mut [u8]) -> Result {
+        self.transfer(&mut [Transfer::write(write_buf), Transfer::read(read_buf)])
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

