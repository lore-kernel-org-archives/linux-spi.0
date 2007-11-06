From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: SD/MMC over SPI on 2.6.24-rc1
Date: Tue, 6 Nov 2007 14:47:52 -0800
Message-ID: <200711061447.52236.david-b@pacbell.net>
References: <200711062132.lA6LWOLr005428@smtp43.singnet.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cksim-rdc5FV7LBygPGFelY5Zqew@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200711062132.lA6LWOLr005428-kStlDfoawLFc9vzhF02D5Ynh5Q2U4q7d@public.gmane.org>
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

On Tuesday 06 November 2007, cksim wrote:
> I have 2 questions with regards to SD/MMC over SPI.

Answering one at a time ...

> 1) In the code, I have commented out all other SPI devices on SPI0 bus
> except for the SD card at spi0.3. However, I got an error "can't share SPI
> bus". Anyone can advise what is the reason behind this error ?

This should be resolved in the current GIT code.  Getting rid of the
class_device caused the "is this bus shared" check to break, and
ISTR the fix was merged shortly after RC1.


> ...
> 
> Lastly, I would like to know if the SD/MMC over SPI can be shared with other
> SPI devices, such as touchscreen controller ADS7843 (purposely left out in
> the current code) ?

By "shared" I presume you mean allowing e.g. both the MMC and
touchscreen operations on the same bus, rather than continuing
with the current "MMC must be alone" restriction?


The issue is that MMC needs a way to issue a sequence of SPI
messages without allowing another device on the bus.  For
example, issuing a "read block" command, is one operation;
then there can be several operations reading "busy" status
until the card has data; then another operation reading that
data block; and then a final operation.

The way SPI normally works is that when one message completes,
the next one in the controller queue is handled.  Which could
mean for example reading touchscreen sensor values ... while
that MMC card is writing "busy" status on the MISO line.  So
the touchscreen sensor values would be corrupted, and maybe
that MMC data block would be lost ...

There are a couple nuances there (notably that it's possible
to drop acess to the bus during that "busy" state), but the
key point is that unless (and until!) the SPI stack gets a
new primitive to let drivers temporarily get exclusive access,
sharing a bus segment between MMC and anything else can't work.


There are a few proposals for such an API extension that I
know about, and as more people start to care about mmc_spi
it seems likely they'll attract interest that has previously
been lacking.  ;)

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
