From: yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: SPI: DUAL/QUAD support
Date: Fri, 5 Jul 2013 17:07:06 +0800
Message-ID: <CAHSAbzM1PGoMXFNOmB7guDsVWYnRoRy89-bufHYpPz5+odnd8w@mail.gmail.com>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
	<20130704130017.GA25997@sig21.net>
	<OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
	<20130704154927.GE27646@sirena.org.uk>
	<OFAD729A05.8C915625-ONC1257B9E.00576B25-C1257B9E.0058477D@rohde-schwarz.com>
	<CAHSAbzOg+uHndydSC43moF7pijc67pqzB2rPnY69ynXHEzw79g@mail.gmail.com>
	<51D67851.8020402@ti.com>
	<CAHSAbzNvMo_oeaqtzO8-xDm-L-f8wVccVqfuVqbR=OwqWJhVwg@mail.gmail.com>
	<51D689F3.3070605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mtd <linux-mtd-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Johannes Stezenbach <js-FF7aIK3TAVNeoWH0uzbU5w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Thomas.Betker-Bf/A/FSCP0w3s4ca2cGeAgC/G2K4zDHf@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <51D689F3.3070605-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>                     if (!quad_mode)
>                             dra7xxx_writel(qspi, qspi->cmd | QSPI_RD_SNGL,
>                                             QSPI_SPI_CMD_REG);
>                     else
>                             dra7xxx_writel(qspi, qspi->cmd | QSPI_RD_QUAD,
>                                             QSPI_SPI_CMD_REG);
>                  .......
>                 }

So what do you based on to set variable quad_mode.

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
