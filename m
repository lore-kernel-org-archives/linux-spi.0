From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH V2] mxs: spi: clear XFER_COUNT in ctrl0 field in DMA
	descriptor
Date: Mon, 7 Jan 2013 13:13:04 +0100
Message-ID: <201301071313.04309.marex@denx.de>
References: <1356500931-31861-1-git-send-email-juha.lumme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Juha Lumme <juha.lumme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1356500931-31861-1-git-send-email-juha.lumme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Juha Lumme,

> On MX23 the XFER_COUNT part in ctrl0 field in DMA descriptor was improperly
> OR'd during the construction of DMA descriptor chain, instead of being
> freshly set.
> Because of that too many bytes were being expected from SPI during the last
> DMA cycle.
> This caused a timeout (SSP_TIMEOUT) to happen in the processing of the last
> DMA descriptor, and thus reads and writes were failing.
> This is a fix for the problem, by clearing XFER_COUNT bytes in ctrl0 before
> setting the new XFER_COUNT for DMA descriptor.
> 
> Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Signed-off-by: Juha Lumme <juha.lumme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Bump? This is stable matter too.

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122412
