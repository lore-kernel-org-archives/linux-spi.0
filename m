From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: [patch 2.6.23-rc3-git] SPI driver
	hotplug/coldplug fixes
Date: Thu, 23 Aug 2007 10:29:58 +0900 (JST)
Message-ID: <20070823.102958.126573100.nemoto@toshiba-tops.co.jp>
References: <200708221315.12184.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org,
	a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org, akonovalov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
To: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200708221315.12184.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Wed, 22 Aug 2007 13:15:11 -0700, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> The basic rule for platform, SPI, and (new style) I2C drivers is just
> to make sure that modprobing the driver name works.  In this case, all
> the relevant drivers are platform drivers, and this patch either
> 
>   (a)	Changes the driver name, if no in-tree code would break;
> 	this is simpler and thus preferable in the long term.
> 
>   (b)	Adds MODULE_ALIAS directives, when in-tree platforms declare
> 	devices using the current driver name; less desirable.

For spi_txx9 part, I can make a patch to fix the driver name and
relevant platform code (there is only one now) ether, if you dropped
the part from your patch.  I'd like to go "preferable in the long
term" way for this new driver.

Of course we can remove MODULE_ALIAS when we changed the name, so no
problem with adding MODULE_ALIAS now.

---
Atsushi Nemoto

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
