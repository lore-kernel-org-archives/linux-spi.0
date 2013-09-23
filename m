From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RESEND] spi/tegra114: Correct support for cs_change
Date: Mon, 23 Sep 2013 13:58:27 -0600
Message-ID: <52409D63.3020909@wwwdotorg.org>
References: <1379528245-6283-1-git-send-email-rklein@nvidia.com> <52408DC8.3020407@wwwdotorg.org> <52409B1E.3030405@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
To: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52409B1E.3030405-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 09/23/2013 01:48 PM, Rhyland Klein wrote:
> On 9/23/2013 2:51 PM, Stephen Warren wrote:
>> On 09/18/2013 12:17 PM, Rhyland Klein wrote:
>>> The tegra114 driver wasn't currently handling the cs_change functionality.
>>> It is meant to invert normal behavior, and we were only using it to possibly
>>> delay at the end of a transfer.
...
>>> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
...
>>> @@ -717,7 +718,12 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
>>>  		else if (req_mode == SPI_MODE_3)
>>>  			command1 |= SPI_CONTROL_MODE_3;
>>>  
>>> -		tegra_spi_writel(tspi, command1, SPI_COMMAND1);
>>> +		if (tspi->cs_control) {
>>> +			if (tspi->cs_control != spi)
>>> +				tegra_spi_writel(tspi, command1, SPI_COMMAND1);
>>
>> Do you really need a separate write call there? The value of command1
>> isn't fully set up there (the CS bits are all set up immediately after),
>> so won't that glitch the CS lines in some cases?
> 
> On our hardware (as far as I've seen), the CS line is normally low. We

I assume you meant "normally *active* low", not "normally low"?

> need to generate a falling-edge to trigger the beginning of a SPI
> transaction. Doing this write with the default value of SPI_COMMAND1
> causes a brief rise and fall of CS, giving us our falling-edge.

That sounds like exactly the glitch I was talking about.

Assuming CS isn't held constantly asserted (low), isn't CS de-asserted
(rises) at the end of transaction n-1, and re-asserted (falls) at the
start of transaction n? If so, I'm not sure why the setup for
transaction n needs to both de-assert and then re-assert it? It seems
like cs_control should be handled at the end of a transaction, not at
the start of the next one.
