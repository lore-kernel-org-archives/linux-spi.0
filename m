From: "Bryan Wu" <cooloney.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] Blackfin SPI driver: move hard
	coded pin_req to board file
Date: Tue, 6 Nov 2007 14:46:47 +0800
Message-ID: <386072610711052246n3c0adff0jc5739db5ab29f238@mail.gmail.com>
References: <1193971112-7744-1-git-send-email-bryan.wu@analog.com>
	<1193971112-7744-4-git-send-email-bryan.wu@analog.com>
	<200711052203.42855.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200711052203.42855.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On 11/6/07, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Thursday 01 November 2007, Bryan Wu wrote:
> > --- a/include/asm-blackfin/bfin5xx_spi.h
> > +++ b/include/asm-blackfin/bfin5xx_spi.h
> > @@ -152,6 +152,7 @@
> > struct bfin5xx_spi_master {
> > u16 num_chipselect;
> > u8 enable_dma;
> > +u16 pin_req[4];
> > };
> >
> > /* spi_board_info.controller_data for SPI slave devices,
>
> I take it there's a patch some where -- outside of this set
> of four -- to initialize that new field so drivers will get
> valid pin setup data?  (That name doesn't sound like it's
> platform data, by the way.)
>
> That's going to need to merge in sync with this patch, else
> I'd think the resulting kernel won't run ...
>

Yes, I have another patch to add this pin_req field in arch/blackfin
board files.
It is in my blackfin patch queue and will be submitted to upstream later.

Thanks a lot
-Bryan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
