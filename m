From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: RE: [PATCH 1/8] spi: spi-ep93xx: use read,write instead of __raw_*
	variants
Date: Mon, 1 Jul 2013 13:17:22 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DAC38FFBA@AUSP01VMBX24.collaborationhost.net>
References: <201306281142.36525.hartleys@visionengravers.com>
	<51CE18FD.8010806@gmail.com> <20130701105750.GI27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"mika.westerberg-X3B1VOXEql0@public.gmane.org" <mika.westerberg-X3B1VOXEql0@public.gmane.org>,
	Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130701105750.GI27646-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Monday, July 01, 2013 3:58 AM, Mark Brown wrote:
> On Sat, Jun 29, 2013 at 09:15:09AM +1000, Ryan Mallon wrote:
>> On 29/06/13 04:42, H Hartley Sweeten wrote:
>
>>> -static inline u8
>>> -ep93xx_spi_read_u8(const struct ep93xx_spi *spi, u16 reg)
>>> -{
>>> -	return __raw_readb(spi->regs_base + reg);
>>> -}
>
>> Is there a particular reason to drop these functions? It's basically just
>> bike-shedding, but they can make the code more readable at very little
>> cost. Even dropping the inline (which is preferred nowdays) the compiler
>> will still inline these, and it would also make this patch much smaller
>> to keep them.
>
> I tend to agree, it's much more normal to have the base + reg in a
> function than not.

OK. I will redo this one to just remove the __raw_.

Regards,
Hartley


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
