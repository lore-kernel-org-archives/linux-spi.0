From: "Miguel Angel Alvarez" <caronteycerbero-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: IXP4XX
Date: Tue, 05 Aug 2008 16:07:19 +0200
Message-ID: <48985E97.601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
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

Hi.

I am new to this mailing list, so although I have tried to search in the =

mailing list archives without success, maybe I am asking for a trivial =

question. So, please, forgive me.

I am trying to use an SD card in a system with an IXP465. I am using =

kernel 2.6.18 (due to some problems with some Intel libraries), but I =

will understand that your advices will be centered in newest kernels (as =

2.6.26).

I have two main problems / questions:
a) Which should be the "abstract" model to use? MMC/SD driver over an =

SPI host system?
b) IXP465 has an SSP/SPI subsystem, but I cannot found a driver to use =

it. Does it exist? Is it the same as pxa2xx (it seems similar)? I think =

bitbanging is not the main option (as far as I understand), because the =

SPI lines do not go to gpios.

Any clue / guide / help would be appreciated.

Thanks

Miguel =C1ngel =C1lvarez
This message (and any associated files) is intended only for the =

use of the individual or entity to which it is addressed and may =

contain information that is confidential, subject to copyright or
constitutes a trade secret. If you are not the intended recipient =

you are hereby notified that any dissemination, copying or =

distribution of this message, or files associated with this message, =

is strictly prohibited. If you have received this message in error, =

please notify us immediately by replying to the message and deleting =

it from your computer. Messages sent to and from us may be monitored. =


Internet communications cannot be guaranteed to be secure or error-free =

as information could be intercepted, corrupted, lost, destroyed, arrive =

late or incomplete, or contain viruses. Therefore, we do not accept =

responsibility for any errors or omissions that are present in this =

message, or any attachment, that have arisen as a result of e-mail =

transmission. If verification is required, please request a hard-copy =

version. Any views or opinions presented are solely those of the author =

and do not necessarily represent those of the company.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
