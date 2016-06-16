From: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC] regmap: Add regmap_pipe_read API
Date: Thu, 16 Jun 2016 18:24:36 +0300
Message-ID: <7ca3857aa8869a1e1f4709860f57f7d92abf1c6b.1466089603.git.leonard.crestez@intel.com>
Cc: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The regmap API usually assumes that bulk read operations will read a
range of registers but some I2C/SPI devices have certain registers for
which a such a read operation will return data from an internal FIFO
instead. Add an explicit API to support bulk read with pipe rather than
range semantics.

Some linux drivers use regmap_bulk_read or regmap_raw_read for such
registers, for example mpu6050 or bmi150 from IIO. This only happens to
work because when caching is disabled a single regmap read op will map
to a single bus read op (as desired). This breaks if caching is enabled and
reg+1 happens to be a cacheable register.

Without regmap support refactoring a driver to enable regmap caching
requires separate I2C and SPI paths. This is exactly what regmap is
supposed to help avoid.

Suggested-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

This works as expected for mpu6050 i2c/spi. Unfortunately looking through the
regmap_bus implementations it looks that at least regmap_spmi_base_read assumes
range semantics at the regmap_hw_read level. If any SPMI devices exist that
have registers with this kind of pipe semantics the correct way to handle them
would be reading from the same register in a loop.

I'd say the correct way to handle this would be to add a regmap_hw_pipe_read
bus operation which is almost always implemented identically to regmap_hw_read.
If that operation is missing regmap_pipe_read should attempt to read_reg in a
loop.

I'm also not absolutely certain that a separate API is required. The
regmap_raw_read currently doesn't work because it check for a
"regmap_volatile_range" which returns true only if the entire range is
volatile. It's not clear if this is intentional?

 drivers/base/regmap/regmap.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h       |  9 +++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index df2d2ef..342f326 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2408,6 +2408,68 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 EXPORT_SYMBOL_GPL(regmap_raw_read);
 
 /**
+ * regmap_pipe_read(): Read data from a register with pipe semantics
+ *
+ * @map: Register map to read from
+ * @reg: Register to read from
+ * @val: Pointer to data buffer
+ * @val_len: Length of output buffer in bytes.
+ *
+ * The regmap API usually assumes that bulk bus read operations will read a
+ * range of registers. Some devices have certain registers for which a read
+ * operation read will read from an internal FIFO.
+ *
+ * The target register must be volatile but registers after it can be
+ * completely unrelated cacheable registers.
+ *
+ * This will attempt multiple reads as required to read val_len bytes.
+ *
+ * A value of zero will be returned on success, a negative errno will be
+ * returned in error cases.
+ */
+int regmap_pipe_read(struct regmap *map, unsigned int reg,
+		     void *val, size_t val_len)
+{
+	size_t read_len;
+	int ret;
+
+	if (!map->bus)
+		return -EINVAL;
+	if (!map->bus->read)
+		return -ENOTSUPP;
+	if (val_len % map->format.val_bytes)
+		return -EINVAL;
+	if (!IS_ALIGNED(reg, map->reg_stride))
+		return -EINVAL;
+	if (val_len == 0)
+		return -EINVAL;
+
+	map->lock(map->lock_arg);
+
+	if (!regmap_volatile(map, reg)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	while (val_len) {
+		if (map->max_raw_read && map->max_raw_read < val_len)
+			read_len = map->max_raw_read;
+		else
+			read_len = val_len;
+		ret = _regmap_raw_read(map, reg, val, read_len);
+		if (ret)
+			goto out_unlock;
+		val = ((u8*)val) + read_len;
+		val_len -= read_len;
+	}
+
+out_unlock:
+	map->unlock(map->lock_arg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regmap_pipe_read);
+
+/**
  * regmap_field_read(): Read a value to a single register field
  *
  * @field: Register field to read from
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 3dc08ce..18ee90e 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -719,6 +719,8 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
 int regmap_raw_read(struct regmap *map, unsigned int reg,
 		    void *val, size_t val_len);
+int regmap_pipe_read(struct regmap *map, unsigned int reg,
+		     void *val, size_t val_len);
 int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		     size_t val_count);
 int regmap_update_bits_base(struct regmap *map, unsigned int reg,
@@ -955,6 +957,13 @@ static inline int regmap_raw_read(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_pipe_read(struct regmap *map, unsigned int reg,
+				   void *val, size_t val_len)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_bulk_read(struct regmap *map, unsigned int reg,
 				   void *val, size_t val_count)
 {
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
