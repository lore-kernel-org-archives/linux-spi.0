From: yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: SPI: DUAL/QUAD support
Date: Fri, 5 Jul 2013 14:25:09 +0800
Message-ID: <CAHSAbzOg+uHndydSC43moF7pijc67pqzB2rPnY69ynXHEzw79g@mail.gmail.com>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
	<20130704130017.GA25997@sig21.net>
	<OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
	<20130704154927.GE27646@sirena.org.uk>
	<OFAD729A05.8C915625-ONC1257B9E.00576B25-C1257B9E.0058477D@rohde-schwarz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mtd <linux-mtd-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Johannes Stezenbach <js-FF7aIK3TAVNeoWH0uzbU5w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thomas.Betker-Bf/A/FSCP0w3s4ca2cGeAgC/G2K4zDHf@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <OFAD729A05.8C915625-ONC1257B9E.00576B25-C1257B9E.0058477D-Bf/A/FSCP0w3s4ca2cGeAgC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Thomas:

>> Well, there's two bits here.  One is the support in the client drivers
>> for using the extra data lines and the other is the support in the SPI
>> core for telling controllers to do this.  We need that second bit in
>> place before the first one can be implemented.
>
> I am not sure if we do. In the system I am working on, the QSPI controller
> recognizes the quad mode commands from the Tx data and automatically
> switches modes; no manual intervention by the flash driver is needed.
>
> I agree that this may not be the case for all SPI controllers. Yuhang, can
> you tell us what your controller will do?

OK, well my spi controller just sets the certain transfer mode in the register
to make it in that mode(single,dual,quad). Then it will send and receive datas
with the specific lines. As master, it should be told the transfer lines by the
slave. Thus I need some members to deliver the information.

But what you said "QSPI controller recognizes the quad mode commands
from the Tx data and automatically switches modes;"  I can not figure out.
The communication is launched by SPI master, so how can the controller
recognizes the Tx data in the first transmission.

>Yes, there are usually different opcodes, and as far as I know, they are
>not supported by the m25p80 driver. It seems we are missing some
>background info here.
>My guess is that the flash chip in question is configured to treat single
>mode opcodes as dual or quad mode commands (some chips support this), and
>that the SPI controller needs to be told, for each transfer, which mode to
>use.
Just as Johannes said. In my patch m25p80's changes is incomplete.
Because my inicial aim is to add the transfer width member to tell controller
the mode flash in. And I will attach new patch about m25p80 later.
Also you are right. There are really series of flashes do not support dual/quad
transfer. So I don't know whether there are any standard for serial-flash just
like the CFI for parallel-flash. Personally, to make a general standard and
a general code for serial-flash is necessary. So that we do not need to add
special function in m25p80.c.

Thanks,
yuhang

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
