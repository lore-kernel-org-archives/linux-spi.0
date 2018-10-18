From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v3 lora-next 1/5] regmap: Add regmap_noinc_write API
Date: Thu, 18 Oct 2018 18:59:52 +0200
Message-ID: <2908e406-a2e3-29cb-579c-949ddd383e97@suse.de>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
 <1539361567-3602-2-git-send-email-ben.whitten@lairdtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: starnight@g.ncu.edu.tw, hasnain.virk@arm.com,
        netdev@vger.kernel.org, liuxuenetmail@gmail.com, shess@hessware.de,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Stefan Rehm <rehm@miromico.ch>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Ben Whitten <ben.whitten@gmail.com>,
        Mark Brown <broonie@kernel.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1539361567-3602-2-git-send-email-ben.whitten@lairdtech.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am 12.10.18 um 18:26 schrieb Ben Whitten:
> The regmap API had a noinc_read function added for instances where devices
> supported returning data from an internal FIFO in a single read.
> 
> This commit adds the noinc_write variant to allow writing to a non
> incrementing register, this is used in devices such as the sx1301 for
> loading firmware.
> 
> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>

Reviewed-by: Andreas Färber <afaerber@suse.de>

Mark, please take this one through your tree - I'll rebase the LoRa
parts on linux-next then.

Thanks,
Andreas

> ---
>  drivers/base/regmap/internal.h |  3 ++
>  drivers/base/regmap/regmap.c   | 77 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/regmap.h         | 19 +++++++++++
>  3 files changed, 99 insertions(+)
> 
> diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
> index a6bf34d63..404f123 100644
> --- a/drivers/base/regmap/internal.h
> +++ b/drivers/base/regmap/internal.h
> @@ -94,11 +94,13 @@ struct regmap {
>  	bool (*readable_reg)(struct device *dev, unsigned int reg);
>  	bool (*volatile_reg)(struct device *dev, unsigned int reg);
>  	bool (*precious_reg)(struct device *dev, unsigned int reg);
> +	bool (*writeable_noinc_reg)(struct device *dev, unsigned int reg);
>  	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
>  	const struct regmap_access_table *wr_table;
>  	const struct regmap_access_table *rd_table;
>  	const struct regmap_access_table *volatile_table;
>  	const struct regmap_access_table *precious_table;
> +	const struct regmap_access_table *wr_noinc_table;
>  	const struct regmap_access_table *rd_noinc_table;
>  
>  	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
> @@ -183,6 +185,7 @@ bool regmap_writeable(struct regmap *map, unsigned int reg);
>  bool regmap_readable(struct regmap *map, unsigned int reg);
>  bool regmap_volatile(struct regmap *map, unsigned int reg);
>  bool regmap_precious(struct regmap *map, unsigned int reg);
> +bool regmap_writeable_noinc(struct regmap *map, unsigned int reg);
>  bool regmap_readable_noinc(struct regmap *map, unsigned int reg);
>  
>  int _regmap_write(struct regmap *map, unsigned int reg,
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index 0360a90..d4f1fc6 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -168,6 +168,17 @@ bool regmap_precious(struct regmap *map, unsigned int reg)
>  	return false;
>  }
>  
> +bool regmap_writeable_noinc(struct regmap *map, unsigned int reg)
> +{
> +	if (map->writeable_noinc_reg)
> +		return map->writeable_noinc_reg(map->dev, reg);
> +
> +	if (map->wr_noinc_table)
> +		return regmap_check_range_table(map, reg, map->wr_noinc_table);
> +
> +	return true;
> +}
> +
>  bool regmap_readable_noinc(struct regmap *map, unsigned int reg)
>  {
>  	if (map->readable_noinc_reg)
> @@ -777,11 +788,13 @@ struct regmap *__regmap_init(struct device *dev,
>  	map->rd_table = config->rd_table;
>  	map->volatile_table = config->volatile_table;
>  	map->precious_table = config->precious_table;
> +	map->wr_noinc_table = config->wr_noinc_table;
>  	map->rd_noinc_table = config->rd_noinc_table;
>  	map->writeable_reg = config->writeable_reg;
>  	map->readable_reg = config->readable_reg;
>  	map->volatile_reg = config->volatile_reg;
>  	map->precious_reg = config->precious_reg;
> +	map->writeable_noinc_reg = config->writeable_noinc_reg;
>  	map->readable_noinc_reg = config->readable_noinc_reg;
>  	map->cache_type = config->cache_type;
>  
> @@ -1298,6 +1311,7 @@ int regmap_reinit_cache(struct regmap *map, const struct regmap_config *config)
>  	map->readable_reg = config->readable_reg;
>  	map->volatile_reg = config->volatile_reg;
>  	map->precious_reg = config->precious_reg;
> +	map->writeable_noinc_reg = config->writeable_noinc_reg;
>  	map->readable_noinc_reg = config->readable_noinc_reg;
>  	map->cache_type = config->cache_type;
>  
> @@ -1898,6 +1912,69 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
>  EXPORT_SYMBOL_GPL(regmap_raw_write);
>  
>  /**
> + * regmap_noinc_write(): Write data from a register without incrementing the
> + *			register number
> + *
> + * @map: Register map to write to
> + * @reg: Register to write to
> + * @val: Pointer to data buffer
> + * @val_len: Length of output buffer in bytes.
> + *
> + * The regmap API usually assumes that bulk bus write operations will write a
> + * range of registers. Some devices have certain registers for which a write
> + * operation can write to an internal FIFO.
> + *
> + * The target register must be volatile but registers after it can be
> + * completely unrelated cacheable registers.
> + *
> + * This will attempt multiple writes as required to write val_len bytes.
> + *
> + * A value of zero will be returned on success, a negative errno will be
> + * returned in error cases.
> + */
> +int regmap_noinc_write(struct regmap *map, unsigned int reg,
> +		      const void *val, size_t val_len)
> +{
> +	size_t write_len;
> +	int ret;
> +
> +	if (!map->bus)
> +		return -EINVAL;
> +	if (!map->bus->write)
> +		return -ENOTSUPP;
> +	if (val_len % map->format.val_bytes)
> +		return -EINVAL;
> +	if (!IS_ALIGNED(reg, map->reg_stride))
> +		return -EINVAL;
> +	if (val_len == 0)
> +		return -EINVAL;
> +
> +	map->lock(map->lock_arg);
> +
> +	if (!regmap_volatile(map, reg) || !regmap_writeable_noinc(map, reg)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	while (val_len) {
> +		if (map->max_raw_write && map->max_raw_write < val_len)
> +			write_len = map->max_raw_write;
> +		else
> +			write_len = val_len;
> +		ret = _regmap_raw_write(map, reg, val, write_len);
> +		if (ret)
> +			goto out_unlock;
> +		val = ((u8 *)val) + write_len;
> +		val_len -= write_len;
> +	}
> +
> +out_unlock:
> +	map->unlock(map->lock_arg);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(regmap_noinc_write);
> +
> +/**
>   * regmap_field_update_bits_base() - Perform a read/modify/write cycle a
>   *                                   register field.
>   *
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 379505a..de04dc4 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -268,6 +268,13 @@ typedef void (*regmap_unlock)(void *);
>   *                field is NULL but precious_table (see below) is not, the
>   *                check is performed on such table (a register is precious if
>   *                it belongs to one of the ranges specified by precious_table).
> + * @writeable_noinc_reg: Optional callback returning true if the register
> + *			supports multiple write operations without incrementing
> + *			the register number. If this field is NULL but
> + *			wr_noinc_table (see below) is not, the check is
> + *			performed on such table (a register is no increment
> + *			writeable if it belongs to one of the ranges specified
> + *			by wr_noinc_table).
>   * @readable_noinc_reg: Optional callback returning true if the register
>   *			supports multiple read operations without incrementing
>   *			the register number. If this field is NULL but
> @@ -302,6 +309,7 @@ typedef void (*regmap_unlock)(void *);
>   * @rd_table:     As above, for read access.
>   * @volatile_table: As above, for volatile registers.
>   * @precious_table: As above, for precious registers.
> + * @wr_noinc_table: As above, for no increment writeable registers.
>   * @rd_noinc_table: As above, for no increment readable registers.
>   * @reg_defaults: Power on reset values for registers (for use with
>   *                register cache support).
> @@ -352,6 +360,7 @@ struct regmap_config {
>  	bool (*readable_reg)(struct device *dev, unsigned int reg);
>  	bool (*volatile_reg)(struct device *dev, unsigned int reg);
>  	bool (*precious_reg)(struct device *dev, unsigned int reg);
> +	bool (*writeable_noinc_reg)(struct device *dev, unsigned int reg);
>  	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
>  
>  	bool disable_locking;
> @@ -369,6 +378,7 @@ struct regmap_config {
>  	const struct regmap_access_table *rd_table;
>  	const struct regmap_access_table *volatile_table;
>  	const struct regmap_access_table *precious_table;
> +	const struct regmap_access_table *wr_noinc_table;
>  	const struct regmap_access_table *rd_noinc_table;
>  	const struct reg_default *reg_defaults;
>  	unsigned int num_reg_defaults;
> @@ -979,6 +989,8 @@ int regmap_write(struct regmap *map, unsigned int reg, unsigned int val);
>  int regmap_write_async(struct regmap *map, unsigned int reg, unsigned int val);
>  int regmap_raw_write(struct regmap *map, unsigned int reg,
>  		     const void *val, size_t val_len);
> +int regmap_noinc_write(struct regmap *map, unsigned int reg,
> +		     const void *val, size_t val_len);
>  int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
>  			size_t val_count);
>  int regmap_multi_reg_write(struct regmap *map, const struct reg_sequence *regs,
> @@ -1222,6 +1234,13 @@ static inline int regmap_raw_write_async(struct regmap *map, unsigned int reg,
>  	return -EINVAL;
>  }
>  
> +static inline int regmap_noinc_write(struct regmap *map, unsigned int reg,
> +				    const void *val, size_t val_len)
> +{
> +	WARN_ONCE(1, "regmap API is disabled");
> +	return -EINVAL;
> +}
> +
>  static inline int regmap_bulk_write(struct regmap *map, unsigned int reg,
>  				    const void *val, size_t val_count)
>  {
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
