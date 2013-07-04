From: Thomas.Betker-Bf/A/FSCP0w3s4ca2cGeAgC/G2K4zDHf@public.gmane.org
Subject: Re: SPI: DUAL/QUAD support
Date: Thu, 4 Jul 2013 16:58:52 +0200
Message-ID: <OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
	<20130704130017.GA25997@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mtd <linux-mtd-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Johannes Stezenbach <js-FF7aIK3TAVNeoWH0uzbU5w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130704130017.GA25997-FF7aIK3TAVNeoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello Johannes:

> Doesn't m25p80 need to use different commands (OPCODEs)
> for 2x and 4x speed?  It seems this change is incomplete.

Yes, there are usually different opcodes, and as far as I know, they are 
not supported by the m25p80 driver. It seems we are missing some 
background info here.

My guess is that the flash chip in question is configured to treat single 
mode opcodes as dual or quad mode commands (some chips support this), and 
that the SPI controller needs to be told, for each transfer, which mode to 
use.

E.g., you would send a READ command with the command bytes in single mode 
(t[0].bitwidth is missing in the patch) and the data bytes in dual or quad 
mode. No dummy bytes are used -- the SPI is running at slower speed.

This situation is certainly a bit special. To me, the patch looks like a 
short-time workaround; I would rather see the flash driver support actual 
dual or quad mode commands. Is there any work in progress?

Best regards,
Thomas


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
