From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v2 2/2] spi: octeon: Add thunderx driver
Date: Mon, 1 Aug 2016 11:31:43 -0700
Message-ID: <579F958F.9020508@caviumnetworks.com>
References: <20160728083144.16625-1-jglauber@cavium.com> <20160728083144.16625-3-jglauber@cavium.com> <20160801172838.GW10376@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan Glauber <jglauber@cavium.com>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, David Daney <david.daney@cavium.com>,
	"Steven J . Hill" <steven.hill@cavium.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160801172838.GW10376@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 08/01/2016 10:28 AM, Mark Brown wrote:
> On Thu, Jul 28, 2016 at 10:31:44AM +0200, Jan Glauber wrote:
>
>> +config SPI_THUNDERX
>> +	tristate "Cavium ThunderX SPI controller"
>> +	depends on (ARM64 || CONFIG_TEST) && 64BIT && PCI
>
> You mean COMPILE_TEST.

Yes, we will fix that typo.


>
>> +	p->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(p->clk))
>> +		goto out_unmap;
>
> We're now just using the normal clock API which is good but I'm now
> unclear what is going to ensure that the clock is there - is there some
> other change elsewhere that I'm not aware of?

The clock is an integral part of the SoC and is always running, so it 
will always be there.  All we want to know is the frequency, which is 
supplied by the device tree clock-bindings framework


> We're also not passing
> the resulting error code back to the caller which will break deferred
> probe.
>

Yes, we should do that.

>> +out_clock:
>> +	clk_disable_unprepare(p->clk);
>> +out_clock_devm:
>> +	devm_clk_put(dev, p->clk);
>
> There's no point in using managed allocations if you're going to manually
> free things...

Yes, we should let the automatic cleanup do its work here.

Probably we should consider using pcim_iomap(...) as well


>
