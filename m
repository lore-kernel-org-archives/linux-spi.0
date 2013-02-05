From: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 6/6] spi/ath79: add shutdown handler
Date: Tue, 05 Feb 2013 20:53:12 +0100
Message-ID: <51116328.7000907@openwrt.org>
References: <1356601349-23617-1-git-send-email-juhosg@openwrt.org>
	<1356601349-23617-7-git-send-email-juhosg@openwrt.org>
	<20130205130207.39E9F3E0E30@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130205130207.39E9F3E0E30@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2013.02.05. 14:02 keltez=E9ssel, Grant Likely =EDrta:

>> -static int ath79_spi_remove(struct platform_device *pdev)
>> +static void __ath79_spi_remove(struct platform_device *pdev)
>>  {
>>  	struct ath79_spi *sp =3D platform_get_drvdata(pdev);
>>  =

>> @@ -304,13 +304,23 @@ static int ath79_spi_remove(struct platform_device=
 *pdev)
>>  	iounmap(sp->base);
>>  	platform_set_drvdata(pdev, NULL);
>>  	spi_master_put(sp->bitbang.master);
>> +}
>>  =

>> +static int ath79_spi_remove(struct platform_device *pdev)
>> +{
>> +	__ath79_spi_remove(pdev);
>>  	return 0;
>>  }
>>  =

>> +static void ath79_spi_shutdown(struct platform_device *pdev)
>> +{
>> +	__ath79_spi_remove(pdev);
>> +}
> =

> Just call ath79_spi_remote(pdev) directly from ath79_spi_shutdown(). No
> need for the extra hook and __ version of the original function.

Ok, I will send a modified patch.

Thanks,
Gabor

---------------------------------------------------------------------------=
---
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 =

and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
