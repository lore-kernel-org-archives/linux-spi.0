From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: SPI Framework in Linux
Date: Thu, 1 Jul 2010 09:18:29 -0700 (PDT)
Message-ID: <392627.77814.qm@web180307.mail.gq1.yahoo.com>
References: <AANLkTimMpQXQyj4bmsIDxu-OtK15532g5ArjGIfQSMwy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, glikely <glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	ananth <ananth86coolguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTimMpQXQyj4bmsIDxu-OtK15532g5ArjGIfQSMwy-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



--- On Thu, 7/1/10, ananth <ananth86coolguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> =

> =A0 I am learning the SPI framework in linux. I read the
> spi-summary and
> documentation. I couldn't get a clear picture of what's
> happening. Is there
> any other document or article which gives a overview of the
> SPI framework in
> linux?

Kerneldoc ... "make pdfdocs" and read the
section on SPI.


Also could you give me any driver which uses SPI for
> communicating
> with devices like touchscreen or other SPI compatible

Like the ads7846 driver?  Kind of old and
complex.  Or the at45 EEPROM driver, which
is much simpler.  There are also SPI flash
drivers in the MTD subtree.

Look harder in the kernel source tree...




---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
