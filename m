From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: Re: [PATCH RESEND] ARM/SPI: New driver for SPI master controller
	for CLPS711X-target
Date: Wed, 5 Dec 2012 00:33:31 +0400
Message-ID: <20121205003331.9dd3d8f4eee2dfe84e7c08fa@mail.ru>
References: <1352309429-21482-1-git-send-email-shc_work@mail.ru>
	<201211122143.34537.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Olof,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201211122143.34537.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 12 Nov 2012 21:43:34 +0000
Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:

> On Wednesday 07 November 2012, Alexander Shiyan wrote:
> > This patch add new driver for CLPS711X SPI master controller.
> > Due to platform limitations driver supports only 8 bit transfer mode.
> > Chip select control is handled via GPIO.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
> 
> Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> 

Please apply this patch in the SPI tree.

-- 
Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
