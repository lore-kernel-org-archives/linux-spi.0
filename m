From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/3] spi: allow registering empty spi_board_info lists
Date: Tue, 28 Feb 2017 10:26:05 -0800
Message-ID: <20170228182605.GB20776@dtor-ws>
References: <20170228041857.13292-1-dmitry.torokhov@gmail.com>
 <20170228041857.13292-4-dmitry.torokhov@gmail.com>
 <CAHp75VffHAn4Sv=710ne8UVNY-em4=LR+4=4jGoCpw-AHoYJ=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VffHAn4Sv=710ne8UVNY-em4=LR+4=4jGoCpw-AHoYJ=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 28, 2017 at 04:01:46PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 28, 2017 at 6:18 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Many boards form list of spi_board_info entries depending on config,
> > and it is possible to end up with empty list. Do not report error
> > in such cases.
> 
> If there is an actual case already it would be better to make the
> patch first in the series with Cc: stable@.

arch/blackfin/mach-bf533/boards/ezkit.c: you can get config convoluted
enough so that you'll end up with empty array. But nobody checks the
result of the call, so the failure is not visible. There is no need to
cc stable@ for this.

> 
> FWIW:
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 

Thanks.

-- 
Dmitry
