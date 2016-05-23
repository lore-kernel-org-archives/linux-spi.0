From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] spi: spidev: fix possible arithmetic overflow for
 multi-transfer message
Date: Mon, 23 May 2016 12:23:37 +0100
Message-ID: <5742E839.3040804@mev.co.uk>
References: <1427133027-8134-1-git-send-email-abbotti@mev.co.uk>
 <CAKdAkRTEWthr6+FjkyukKN0-1YDAziy91Ww+tTOOE4MGkH2k1Q@mail.gmail.com>
 <20160523111521.GQ8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>,
	"3.8+" <stable@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160523111521.GQ8206@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 23/05/16 12:15, Mark Brown wrote:
> On Sat, May 21, 2016 at 09:50:35AM -0700, Dmitry Torokhov wrote:
>> On Mon, Mar 23, 2015 at 10:50 AM, Ian Abbott <abbotti@mev.co.uk> wrote:
>>> `spidev_message()` sums the lengths of the individual SPI transfers to
>>> determine the overall SPI message length.  It restricts the total
>>> length, returning an error if too long, but it does not check for
>
> As documented in SubmittingPatches please send patches to the
> maintainers for the code you would like to change.  The normal kernel
> workflow is that people apply patches from their inboxes, if they aren't
> copied they are likely to not see the patch at all and it is much more
> difficult to apply patches.
>

In this case, Dmitry was replying to my patch that has already been 
applied over a year ago. :)

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
