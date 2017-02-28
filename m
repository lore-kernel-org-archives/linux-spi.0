From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/3] spi: allocate spi_board_info entries one by one
Date: Tue, 28 Feb 2017 21:52:27 +0100
Message-ID: <1d4ee33c-cf17-27a6-5bd6-f50c96906426@metafoo.de>
References: <20170228041857.13292-1-dmitry.torokhov@gmail.com>
 <20170228041857.13292-3-dmitry.torokhov@gmail.com>
 <20170228091650.eiypppxblfhh33pb@sirena.org.uk>
 <20170228182417.GA20776@dtor-ws>
 <20170228185455.mdmvuc232chlveve@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170228185455.mdmvuc232chlveve@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 02/28/2017 07:54 PM, Mark Brown wrote:
> On Tue, Feb 28, 2017 at 10:24:17AM -0800, Dmitry Torokhov wrote:
>> On Tue, Feb 28, 2017 at 09:16:50AM +0000, Mark Brown wrote:
>>> On Mon, Feb 27, 2017 at 08:18:56PM -0800, Dmitry Torokhov wrote:
>>>> Lists of spi_board_info entries registered with spi_register_board_info()
>>>> can be quite long; instead of forcing memory allocator find contagious
> 
>>> Do you have numbers on that?
> 
>> Hm, so the largest array seems to be in
>> arch/blackfin/mach-bf537/boards/stamp.c at max of 43 entries. The new
>> board info is ether 60 or 72 bytes, so we get 2 or 3K table. Not above
>> page, but still could be packed I think.
> 
> Oh wow, that's impressively large.  Still not sure the optimization is
> particularly worth it though, it's small change in the grand scheme of
> things.  OTOH it's a small change.

The Blackfin machine files shouldn't be used as valid example. While in
theory it is possible to build a kernel with that many entries nobody is
ever going to do that. What the Blackfin machine files do is basically a
poor man's overlays from the days before overlays existed. Most of the
entries in the table use the same chip-select pins, it wouldn't be possible
to use  use a setup where more than two or three of the entries is enabled
at the same time.
