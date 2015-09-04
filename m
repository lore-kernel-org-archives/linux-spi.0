From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 8/9] spi: rockchip: modify DMA max burst
	to 1
Date: Fri, 4 Sep 2015 08:03:26 +0800
Message-ID: <55E8DFCE.5040504@rock-chips.com>
References: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
 <1441101524-1700-1-git-send-email-shawn.lin@rock-chips.com>
 <20150903125429.GA12027@sirena.org.uk> <55E84E17.2090409@rock-chips.com>
 <20150903174502.GI5313@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Addy Ke <addy.ke@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>,
 Sonny Rao <sonnyrao@chromium.org>, shawn.lin@rock-chips.com,
 Olof Johansson <olof@lixom.net>, linux-spi@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Doug Anderson <dianders@chromium.org>,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org, Olof Johansson <olofj@google.com>,
 linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150903174502.GI5313@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

On 2015/9/4 1:45, Mark Brown wrote:
> On Thu, Sep 03, 2015 at 09:41:43PM +0800, Shawn Lin wrote:
>> On 2015/9/3 20:54, Mark Brown wrote:
>
>>> If this is a quirk of the DMA controller why is it being fixed with a
>>> property specific to the SPI controller?  Can't the DMA controller just
>>> override the burst size?
>
>> Cool...that's a good question. Actually DMA controller can't do that since
>> block peripheral controller(e.g sd/emmc, they always access data by
>> block-512Bytes.) can't meet the case. So It's hard for dma controller know
>> who is the caller, and what should be done.
>
> You could take a guess based on request size, but that's going to be a
> bit error prone I imagine.
>

yes, not always cover all cases.

>> The only thing dma controller can do is avoid to execute DMAFLUSHP on its
>> own. But how about peripheral controller trigger non-multiple access? So
>> that's what I mentioned on covery letter that we should do "broken things"
>> for both dma controller and some peripherals.
>
> The other thing it could do is provide the information out via some
> internal Linux API which the drivers could query instead of directly
> having a DT property in each client driver.  That way at least the DT
> only needs the quirk in one place even if the clients need to handle it
> individually.

Good idea. Thanks, Mark.

>


-- 
Best Regards
Shawn Lin
