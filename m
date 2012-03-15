From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH/RFC] spi: sh-msiof: per-transaction runtime PM
Date: Thu, 15 Mar 2012 17:58:26 +0900
Message-ID: <CANqRtoQUm5PyVwe-PtQPP1DX+_tAh9ptbj9mSkx48+W4Yh9DiA@mail.gmail.com>
References: <Pine.LNX.4.64.1203141828230.30291@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net, linux-sh@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1203141828230.30291@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Mar 15, 2012 at 2:35 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Currently the spi-sh-msiof driver implements a runtime PM scheme, based on
> chipselect toggling. However, this is largely inefficient, since SPI
> client drivers are allowed to keep the chipselect active for long periods
> of time. This patch allows the driver to runtime-suspend the controller
> between SPI transfers. While moving runtime-PM hooks this patch also
> removes manual PM clock manipulation.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> Marked as RFC, because I'm actually not sure, whether suspending after
> each transfer is actually allowed. This seems to bring problems with
> mmc-spi at least. Some commands return errors, but a retry recovers. More
> investigation is required. Any hints concerning why this is not perfectly
> functioning would be appreciated!

Hi Guennadi,

Thanks for your efforts. I believe that the error you are seeing with
this patch applied is because the code has been updated to change the
polarity of some shared SPI bus pins while CS is being asserted. This
will result in potential spikes on the shared SPI bus pins which is
far from perfect. =)

Cheers,

/ magnus
