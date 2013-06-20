From: Girish KS <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 2/3] spi: s3c64xx: Added provision for dedicated cs pin
Date: Thu, 20 Jun 2013 14:52:07 +0530
Message-ID: <CAKrE-KciiPe5Zx7ggxzh=x0xY0xGDhX+=Lt7aL-EgkxinO214w@mail.gmail.com>
References: <1369032694-13183-1-git-send-email-ks.giri@samsung.com>
	<1369032694-13183-3-git-send-email-ks.giri@samsung.com>
	<20130619182354.GD1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130619182354.GD1403-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 19, 2013 at 11:53 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, May 20, 2013 at 12:21:33PM +0530, Girish K S wrote:
>> From: Girish K S <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> The existing driver supports gpio based /cs signal.
>> For controller's that have one device per controller,
>> the slave device's /cs signal might be internally controlled
>> by the chip select bit of slave select register. They are not
>> externally asserted/deasserted using gpio pin.
>>
>> This patch adds support for controllers with dedicated /cs pin.
>> if "cs-gpio" property doesnt exist in a spi dts node, the controller
>> would treat the /cs pin as dedicated.
>
> This breaks SPI operation on my s3c64xx based system since...
>
>>       if (pdev->dev.of_node) {
>> +             if (of_find_property(pdev->dev.of_node, "cs-gpio", NULL))
>> +                     sdd->cs_gpio = true;
>> +
>>               ret = of_alias_get_id(pdev->dev.of_node, "spi");
>>               if (ret < 0) {
>>                       dev_err(&pdev->dev, "failed to get alias id, errno %d\n",
>
> sdd->cs_gpio is only set to true by this code so if you're using a board
> file then the GPIO will be ignored.

Reversing the default assignment for "sdd->cs_gpio" and the following
"if condition" shall handle both dt and non-dt case. Will do it and
resubmit only this patch in the series.

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
