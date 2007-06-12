From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Simple driver for Xilinx SPI
	controler.
Date: Tue, 12 Jun 2007 09:28:08 -0700
Message-ID: <200706120928.09176.david-b@pacbell.net>
References: <4666BF47.8080103@ru.mvista.com>
	<200706062209.09731.david-b@pacbell.net>
	<466ADC4B.4050806@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrei Konovalov <akonovalov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>,
	linuxppc-embedded-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <466ADC4B.4050806-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Saturday 09 June 2007, Andrei Konovalov wrote:
> The new patch is attached to this message.

Would you send a version that doesn't produce so many
warnings when run against scripts/checkpatch.pl ??

The issues seem to be mostly whitespace and linelength,
so that should be easy.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
