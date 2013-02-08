From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 7/7] spi: spi-fsl-spi: Add support for gpio chipselects
	for GRLIB type cores
Date: Fri, 08 Feb 2013 08:46:42 +0100
Message-ID: <5114AD62.1070909@gaisler.com>
References: <1360242731-13700-1-git-send-email-andreas@gaisler.com>
	<1360242731-13700-8-git-send-email-andreas@gaisler.com>
	<20130207160821.GA22224@lizard.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130207160821.GA22224-1CZZkhFgUWNRmOO2HpYVOJIbA5emDH3N@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 2013-02-07 17:08, Anton Vorontsov wrote:
> On Thu, Feb 07, 2013 at 02:12:11PM +0100, Andreas Larsson wrote:
>>   	struct fsl_spi_reg *reg_base;
>> -	int retval;
>> +	int retval, desel;
>
> We don't usually place variable declarations on the same line, unless the
> variables are closely related.
>
>>   	u32 hw_mode;
>>   	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
>>
>> @@ -456,12 +456,45 @@ static int fsl_spi_setup(struct spi_device *spi)
>>   		return retval;
>>   	}
>>
>> +	if (mpc8xxx_spi->type == TYPE_GRLIB) {
>> +		if (gpio_is_valid(spi->cs_gpio)) {
>
> <- You can place the 'int desel;' here, limiting the visibility for it.

Thanks for the feedback!

I'll put that in v3. This last patch needs to wait for the other 
patchset I mentioned anyway.

Cheers,
Andreas


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
