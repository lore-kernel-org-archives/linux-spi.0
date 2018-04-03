From: Sergey Suloev <ssuloev@orpaltech.com>
Subject: Re: [PATCH 5/6] spi: sun4i: introduce register set/unset helpers
Date: Tue, 3 Apr 2018 13:27:57 +0300
Message-ID: <8edccc63-9729-ff4c-b272-1916e7794bc7@orpaltech.com>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-6-ssuloev@orpaltech.com>
 <20180403081458.lyilg3yu3n2e54fd@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180403081458.lyilg3yu3n2e54fd@flea>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/03/2018 11:14 AM, Maxime Ripard wrote:
> On Thu, Mar 29, 2018 at 09:59:06PM +0300, Sergey Suloev wrote:
>> Two helper functions were added in order to update
>> registers easily.
>>
>> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> I'm not really sure what's easier about this one.
>
> Maxime
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

well, just seems more readable vs doing "read, or, write" every time
