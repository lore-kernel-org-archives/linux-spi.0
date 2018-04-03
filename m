From: Sergey Suloev <ssuloev@orpaltech.com>
Subject: Re: [PATCH 2/6] spi: sun4i: restrict transfer length in PIO-mode
Date: Tue, 3 Apr 2018 13:26:34 +0300
Message-ID: <c3b41806-dc12-3af9-8b3a-bd1a611293f8@orpaltech.com>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-3-ssuloev@orpaltech.com>
 <20180403081041.3ully6bcyfwx2cx6@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180403081041.3ully6bcyfwx2cx6@flea>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/03/2018 11:10 AM, Maxime Ripard wrote:
> On Thu, Mar 29, 2018 at 09:59:03PM +0300, Sergey Suloev wrote:
>> There is no need to handle 3/4 empty/full interrupts as the maximum
>> supported transfer length in PIO mode is 64 bytes for sun4i-family
>> SoCs.
> That assumes that you'll be able to treat the FIFO full interrupt and
> drain the FIFO before we have the next byte coming in. This would
> require a real time system, and we're not in one of them.
>
> Maxime
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

so you think we should still handle 3/4 FIFO full ?
