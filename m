From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] SPI: S5P64X0: Enable SPI driver for S5P6440 and S5P6450
Date: Fri, 3 Dec 2010 19:12:21 +0900
Message-ID: <AANLkTin1UkkQOhtScPqsPGMPJYPQuVhj9ddXZhbYddkj@mail.gmail.com>
References: <1291338253-16461-1-git-send-email-sbkim73@samsung.com>
	<015201cb92d0$d03777a0$70a666e0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sangbeom Kim <sbkim73@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Abhilash Kesavan <a.kesavan@samsung.com>,
	dbrownell@users.sourceforge.net, ben-linux@fluff.org
To: Kukjin Kim <kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <015201cb92d0$d03777a0$70a666e0$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Dec 3, 2010 at 6:59 PM, Kukjin Kim <kgene.kim@samsung.com> wrot=
e:
> Sangbeom Kim wrote:
>>
>> From: Abhilash Kesavan <a.kesavan@samsung.com>
>>
>> This patch enable the existing S3C64XX series SPI driver for S5P64X0
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
>> ---
>> =C2=A0drivers/spi/Kconfig | =C2=A0 =C2=A04 ++--
>
> Added following mailing list and maintainers.
> spi-devel-general@lists.sourceforge.net
> David Brownell and Grant Likely (SPI Subsystem's maintainer)

I would have appreciated being CC'ed.

>> =C2=A0config SPI_S3C64XX
>> =C2=A0 =C2=A0 =C2=A0 tristate "Samsung S3C64XX series type SPI"
>> - =C2=A0 =C2=A0 depends on ARCH_S3C64XX && EXPERIMENTAL
>> - =C2=A0 =C2=A0 select S3C64XX_DMA
>> + =C2=A0 =C2=A0 depends on (ARCH_S3C64XX || ARCH_S5P64X0) && EXPERIM=
ENTAL
>
> Do we really still need CONFIG_EXPERIMENTAL here?

I think we can drop it.


>> + =C2=A0 =C2=A0 select S3C64XX_DMA if !ARCH_S5P64X0
>> =C2=A0 =C2=A0 =C2=A0 help
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 SPI driver for Samsung S3C64XX and newer=
 SoCs.
>
> SPI driver for Samsung S3C64XX, S5P64X0 and newer Socs.

S5P64X0 is already a part of  'newer Socs'
