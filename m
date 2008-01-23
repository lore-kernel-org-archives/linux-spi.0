From: "Matt Gessner" <mgessner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Linux 2.6.20 on AT91RM9200 writing SPI
	dataflash AT45DB011B.
Date: Wed, 23 Jan 2008 09:25:58 -0500
Message-ID: <85a5c2010801230625w4643dc94v931613183b018935@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hello,

I've got an AT91RM9200, running 2.6.20.  I'd like to be able to do
something like:

                  % dd if=myfile.dat of=/dev/mtdblock/2

which is an Atmel dataflash on SPI.  I get 'operation not permitted'.
The device file is marked as writable, and I removed the mask bit that
says the device isn't writable.  But I still get operation not
permitted.  at91_dataflash_write is linked into the kernel, but
something is preventing the write().  I'm going to delve down into the
kernel to see what I can discover, but I'm wondering if anyone can
tell me now if this isn't going to work at all.

Thank you in advance,

Regards,

Matt Gessner

P.S. I recently found the place in the kernel that checks to see if
the starting address is aligned with the erase size of the part.
Well, it's not.  However, u-boot doesn't have that particular
restriction, and I'm wondering if I can get around what the kernel's
drivers are doing.  I have a one-time operation I have to do with
something (rewrite the u-boot environment from linux) and if I didn't
have to rewrite all of u-boot, that'd be great too.

Thanks in advance,

Matt

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
