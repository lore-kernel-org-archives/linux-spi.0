From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC] [PATCH v2 1/3] scatterlist: Add support to clone scatterlist
Date: Tue, 5 Jul 2016 19:47:00 +0300
Message-ID: <CAHp75Ve63mW_CBxk-t-VD2m+AT3vB-u7atomT=Cj6jSVDnTP6Q@mail.gmail.com>
References: <1467039249-7816-1-git-send-email-fcooper@ti.com>
 <1467039249-7816-2-git-send-email-fcooper@ti.com> <20160705144957.GC6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Franklin S Cooper Jr <fcooper@ti.com>, david.s.gordon@intel.com,
	Jens Axboe <axboe@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ming Lin <ming.l@ssi.samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Sekhar Nori <nsekhar@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160705144957.GC6247@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 5, 2016 at 5:49 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jun 27, 2016 at 09:54:07AM -0500, Franklin S Cooper Jr wrote:
>> Occasionally there are times you need to tweak a chained S/G list while
>> maintaining the original list. This function will duplicate the passed
>> in chained S/G list and return a pointer to the cloned copy.
>
> This looks reasonable to me and there's not been any other comment over
> a fairly extended period (this wasn't the first posting) so unless
> someone screams I'll probably go ahead and apply this soon.

It has style issues I suppose. Extra empty lines, for example.

I will comment more.

-- 
With Best Regards,
Andy Shevchenko
