From: "LTI. - Ticmanis, Linards" <LTI-mKfYHFOTJHu+onKQ3Rj6Dg@public.gmane.org>
Subject: Revisiting "problem with converting from
	at91_spi to atmel_spi (AT91RM9200)"
Date: Mon, 1 Oct 2007 19:01:35 +0200
Message-ID: <37ED64EE21A398409D609EAF7B0525A02164EB@hw-mail.hannover.huwag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello to all,

I was wondering if the problem described in the thread "problem with conver=
ting from at91_spi to atmel_spi (AT91RM9200)" from last May was ever solved=
, as I'm currently running into the same trouble. at91_spi works nicely wit=
h an at25-driven EEPROM on CS0, but atmel_spi doesn't - it just blocks what=
ever thread is using it.

While that's no problem in the EEPROM case, a customer wants to use SPI bas=
ically as a very fast UART between two AT91RM9200 based boards now, on whic=
h only CS0 is available. Is there no other chance than converting the layou=
t to use another CS instead?

Thanks for any hints offered to this kernel newbie,
-- =

Linards Ticmanis
Team Systemsoftware
Skeye Germany
H=F6ft & Wessel AG

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
