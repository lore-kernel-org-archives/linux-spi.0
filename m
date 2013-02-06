From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spi-fsl-spi: Make spi-fsl-spi usable in cpu
	mode outside of FSL SOC environments and add a grlib variant normally
	running on sparc
Date: Wed, 06 Feb 2013 11:44:27 +0100
Message-ID: <5112340B.7030505@gaisler.com>
References: <1359548124-13692-1-git-send-email-andreas@gaisler.com>
	<20130205175630.C6F7F3E167A@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130205175630.C6F7F3E167A@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 2013-02-05 18:56, Grant Likely wrote:
> On Wed, 30 Jan 2013 13:15:24 +0100, Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> wrote:
>> This patch relies upon parts of the "of, of_gpio, of_spi: Fix and
>> improve of_parse_phandle_with_args, of_gpio_named_count and
>> of_spi_register_master" patchset - https://lkml.org/lkml/2012/12/27/54
>> (v2 at https://lkml.org/lkml/2013/1/29/308).

For TYPE_GRLIB, the gpio chipselect parts relies on this series. It 
would be great to get some feedback on that patch series as well.

>> Maybe the different out/in_be32 vs iowrite/read32be in spi-fsl-lib.h is
>> over the top, but I'm not sure if there might be subtle differences
>> between those on powerpc and I don't have any fsl hardware to try things
>> out on.
>
> Changing to ioread/write globally should be fine. I would change it and get
> someone with an fsl board to try it out. That will reduce the diffstat a
> bit.

Will do.

> As is, this is quite an invasive patch, so I'm not going to be
> comfortable merging it without at least one 3rd party tester. (Breaking
> things up into discrete patches will make me less nervous and possible
> to merge parts while still revising others.

I'll be happy to do that. Was trying to adhere to the guide line to not 
introduce something separately from its usage, but in this case it is 
probably better to split things up a bit.

>> +#ifdef CONFIG_FSL_SOC
>>   	else if (prop && !strcmp(prop, "qe"))
>>   		pdata->flags = SPI_CPM_MODE | SPI_QE;
>>   	else if (of_device_is_compatible(np, "fsl,cpm2-spi"))
>>   		pdata->flags = SPI_CPM_MODE | SPI_CPM2;
>>   	else if (of_device_is_compatible(np, "fsl,cpm1-spi"))
>>   		pdata->flags = SPI_CPM_MODE | SPI_CPM1;
>> +#endif
>
> The ifdefs are ugly and these lines won't affect sparc. Just leave them
> in.

Will do.

>> +/* TYPE_GRLIB SPI Controller capability register definitions */
>> +#define SPCAP_SSEN(x)           (((x) >> 16) & 0x1)
>> +#define SPCAP_SSSZ(x)           (((x) >> 24) & 0xff)
>> +#define SPCAP_MAXWLEN(x)	(((x) >> 20) & 0xf)
>
> Nit: inconsistent whitespace (tabs vs. spaces)

Will fix.

>> +	ret = of_property_read_u32(dev->of_node, "bus-number", &bus_num);
>> +	if (!ret)
>> +		master->bus_num = bus_num;
>
> Drop these lines. Never set the bus number explicitly when using DT. If
> you really want to assign a particular bus number, then use an alias.

Sure, I'll check that out.

> That's all the comments I've got for now, but there are an awful lot of
> #defines that are added to the driver which is kind of ugly. I'm not
> going to nack over that, but it would be good to clean it up and do some
> better abstraction.

I agree that it is ugly. If I move the cpm-related things from 
spi-fsl-spi.c to a separate file that only gets linked on FSL_SOC and 
have dummy functions in an h-file I think that it can be made much less 
ugly.

Thanks for the feedback!

Cheers,
Andreas


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
