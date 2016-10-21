From: Milo Kim <woogyom.kim@gmail.com>
Subject: Re: [PATCH 2/3] spi: sun6i: Support Allwinner H3 SPI controller
Date: Fri, 21 Oct 2016 22:36:53 +0900
Message-ID: <db1e8625-088e-8719-75a4-641fd2580e8f@gmail.com>
References: <20161019140234.13518-1-woogyom.kim@gmail.com>
 <20161019140234.13518-3-woogyom.kim@gmail.com>
 <CAGb2v66xMNXGFSavvNCDxPYxQ_nQCQOVgc=WigQ5VjjxLX-sEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-spi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGb2v66xMNXGFSavvNCDxPYxQ_nQCQOVgc=WigQ5VjjxLX-sEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 10/21/2016 12:53 AM, Chen-Yu Tsai wrote:
> Use of_device_get_match_data, then you don't even have to move sun6i_spi_match
> above this function.

Oh, good. Thanks for introducing this helper.

Best regards,
Milo
