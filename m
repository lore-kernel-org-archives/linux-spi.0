From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 06/12] regulator: add driver for tps6524x regulator
Date: Thu, 14 Oct 2010 22:03:24 +0100
Message-ID: <20101014210323.GB14479@opensource.wolfsonmicro.com>
References: <1287081535-2864-1-git-send-email-cyril@ti.com>
	<1287081535-2864-7-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
To: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1287081535-2864-7-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Oct 14, 2010 at 02:38:49PM -0400, Cyril Chemparathy wrote:
> TPS6524X provides three step-down converters and two general-purpose LDO
> voltage regulators.  This device is interfaced using SPI.
> 
> Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>

This looks mostly good but...

> +static int read(struct tps6524x *hw, int reg)
> +{

I suspect you may run into a namespace issue with this in the future.

> +static const int dcdc1_voltages[] = {
> +	 800000,  825000,  850000,  875000,
> +	 900000,  925000,  950000,  975000,
> +	1000000, 1025000, 1050000, 1075000,
> +	1100000, 1125000, 1150000, 1175000,
> +	1200000, 1225000, 1250000, 1275000,
> +	1300000, 1325000, 1350000, 1375000,
> +	1400000, 1425000, 1450000, 1475000,
> +	1500000, 1525000, 1550000, 1575000,

Looks like you could just do the maths for most of these tables, might
be a bit clearer/simpler?  Not a major issue either way, though.

> +static int list_voltage(struct regulator_dev *rdev, unsigned selector)
> +{
> +	const struct supply_info *info;
> +	struct tps6524x *hw;
> +
> +	hw	= rdev_get_drvdata(rdev);
> +	info	= &supply_info[rdev_get_id(rdev)];
> +
> +	if (info->flags & FIXED_VOLTAGE)
> +		return selector ? -EINVAL : info->fixed_voltage;
> +	else
> +		return (selector < 0 || selector >= info->n_voltages) ?
> +			-EINVAL : info->voltages[selector];

I'm not sure the ternery operator is helping legibility here - if
statements might be more legible.

> +	ret = read_field(hw, &info->voltage);
> +	if (ret < 0)
> +		return ret;
> +	if (ret >= info->n_voltages)
> +		return -EINVAL;

Shouldn't this be warning somehow - if we can't understand the register
setting that'd be a driver bug, -EINVAL makes it sound like an invalid
parameter was supplied.  Similarly for the current limit.

> +static ssize_t show_reg(struct device *dev, struct device_attribute *attr,
> +			char *buf);
> +static ssize_t store_reg(struct device *dev, struct device_attribute *attr,
> +			 const char *buf, size_t size);
> +
> +static DEVICE_ATTR(ldo_set,	0664, show_reg, store_reg);
> +static DEVICE_ATTR(block_en,	0664, show_reg, store_reg);
> +static DEVICE_ATTR(dcdc_set,	0664, show_reg, store_reg);
> +static DEVICE_ATTR(dcdc_en,	0664, show_reg, store_reg);
> +static DEVICE_ATTR(usb,		0664, show_reg, store_reg);
> +static DEVICE_ATTR(alarm,	0664, show_reg, store_reg);
> +static DEVICE_ATTR(int_enable,	0664, show_reg, store_reg);
> +static DEVICE_ATTR(int_status,	0664, show_reg, store_reg);
> +static DEVICE_ATTR(rev_id,	0664, show_reg, store_reg);
> +static DEVICE_ATTR(write_enable,   0664, show_reg, store_reg);
> +static DEVICE_ATTR(software_reset, 0664, show_reg, store_reg);

Large chunks of this looks like it's exporting functionality which is
part of the regulator API to userspace, replicating functionality which
the API provides.  Please either remove or replace with standard
functionality.

The USB setting should be integrated with the USB subsystem, assuming
it's changing a USB current limit.

> +	init_data = dev->platform_data;
> +	if (!init_data) {
> +		dev_err(dev, "could not find regulator platform data\n");
> +		return -EIO;
> +	}

EIO doesn't look right here...
