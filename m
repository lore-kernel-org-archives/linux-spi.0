From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi: rspi: fix build error when CONFIG_OF is not set
Date: Tue, 4 Feb 2014 14:56:40 +0900
Message-ID: <52F08118.2080904@renesas.com>
References: <52EEF452.4060205@renesas.com> <alpine.DEB.2.02.1402030939520.25794@ayla.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Development <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1402030939520.25794-97SZ98TBZzA1xEWliksxXw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert-san,

(2014/02/03 17:47), Geert Uytterhoeven wrote:
> 	Hi Shimoda-san,
> 
> On Mon, 3 Feb 2014, Shimoda, Yoshihiro wrote:
>> This patch fixes an issue that the following build error happens when
>> the CONFIG_OF is not set:
>>
>> drivers/spi/spi-rspi.c: In function 'rspi_probe':
>> drivers/spi/spi-rspi.c:1203:26: error: 'rspi_of_match' undeclared (first use in this function)
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  This patch is based on the latest origin/topic/rspi branch in the spi.git.
>>
>>  drivers/spi/spi-rspi.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
>> index 34ad4bc..e5cfc3d 100644
>> --- a/drivers/spi/spi-rspi.c
>> +++ b/drivers/spi/spi-rspi.c
>> @@ -1164,6 +1164,7 @@ static int rspi_parse_dt(struct device *dev, struct spi_master *master)
>>  	return 0;
>>  }
>>  #else
>> +#define rspi_of_match	NULL
>>  static inline int rspi_parse_dt(struct device *dev, struct spi_master *master)
>>  {
>>  	return -EINVAL;
>> -- 
>> 1.7.1
> 
> Thanks, obviously I missed that of_match_device() still uses the ID table
> parameter if CONFIG_OF=n :-(
> 
> Below I have two alternative solutions:
>   1. Uses rspi_of_match() to nullify the ID table pointer, like is done in
>      the platform_driver structure,
>   2. Fixes it at the OF subsystem level, by nullifying the ID table pointer
>      inside of_match_device().
> 
> If 2 is accepted, drivers don't have to care about this anymore.
> 
> What do you think?

Thank you for the reply.
I think the 2nd one is a nice idea.
If I applied it without my patch, the build error disappeared.

Best regards,
Yoshihiro Shimoda
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
