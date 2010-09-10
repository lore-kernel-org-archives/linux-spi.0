From: =?ISO-8859-1?Q?Fl=E1vio_Alberto_Lopes_Soares?= <flavioalsoares-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Analog Digital Converter - ADS1256 extreme newbie questions
Date: Fri, 10 Sep 2010 02:13:25 -0300
Message-ID: <AANLkTi=VBmpZSuu=9M2Ppypd=q5JrL9eNeoJEmnLu-6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello all,
I'm working 9 years as a Linux C/C++ programmer but I spent 99,9% of this
time working in user space programming, now I need to write a driver to use
the ADS1256 Analog-Digital converter (
http://focus.ti.com/docs/prod/folders/print/ads1256.html ) in an ARM board
using S3C2440 processor, my lecture start point
was Documentation/spi/spi-sumary from 2.6.32.2 kernel tree version and
drivers/misc/eeprom/at25.c code (this is an eeprom driver but I want look
the SPI general view), reading the text and the code I found some conceptual
doubts, my initial idea was create a character device driver and attach the
device read operation with a ADS1256 start lecture and pass the ADC channel
data to this device, this concept is correct ? There's some standard
interface to do this if my idea is wrong ?

Looking in at25.c in at25_probe(struct spi_device *spi) function this
"struct spi_device *spi" parameter represents the S3C2440 SPI controller and
came from SPI core subsystem ? If yes how the SPI controller knows that this
is an eeprom device in the snippet bellow ?
...
const struct spi_eeprom *chip;
...
/* Chip description */
chip =3D spi->dev.platform_data;

who provides this platform_data structure and who knows it must be a struct
spi_eeprom object ?

Thanks for all help

Fl=E1vio Alberto Lopes Soares
---------------------------------------------------------------------------=
---
Automate Storage Tiering Simply
Optimize IT performance and efficiency through flexible, powerful, =

automated storage tiering capabilities. View this brief to learn how
you can reduce costs and improve performance. =

http://p.sf.net/sfu/dell-sfdev2dev
