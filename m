From: Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
Date: Thu, 30 Jan 2020 09:32:06 -0600
Message-ID: <3eaf74eb-1817-a04d-1fc9-146c188584d0@linux.ibm.com>
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <20200130144609.GD6682@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, andrew@aj.id.au
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200130144609.GD6682@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 1/30/20 8:46 AM, Mark Brown wrote:
> On Wed, Jan 29, 2020 at 02:08:24PM -0600, Eddie James wrote:
>
> Overall this looks good, some comments below but they're all fairly
> minor.


Thanks for the quick review! I'll fix what you've suggested below.

Thanks,

Eddie


>
>> +++ b/drivers/spi/spi-fsi.c
>> @@ -0,0 +1,547 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) IBM Corporation 2020
>> + */
> Please make the entire comment a C++ one so things look more
> intentional.
>
>> +
>> +static int fsi_spi_data_in(u64 in, u8 *rx, int len)
>> +{
>> +	int i;
>> +	int num_bytes = len > 8 ? 8 : len;
> Please write normal conditional statements to improve legibility, the
> ternery operator isn't really needed here.
>
>> +static int fsi_spi_reset(struct fsi_spi *ctx)
>> +{
>> +	int rc;
>> +
>> +	dev_info(ctx->dev, "Resetting SPI controller.\n");
> This should be lowered to dev_dbg() at most, it's not really adding
> anything otherwise.
>
>> +static int fsi_spi_remove(struct device *dev)
>> +{
>> +	return 0;
>> +}
> Remove empty functions, if they can safely be empty then it should be
> possible to omit them.
>
>> +static const struct fsi_device_id fsi_spi_ids[] = {
>> +	{ FSI_ENGID_SPI, FSI_VERSION_ANY },
>> +	{ }
>> +};
> This needs a MODULE_DEVICE_TABLE annotation.
