From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] spi: bcm2835: don't print error on clk_get() DEFER
Date: Thu, 12 Dec 2019 15:18:29 -0800
Message-ID: <f9821c68-3883-40a7-ab91-284b5071bd63@gmail.com>
References: <20191212231213.29061-1-jquinlan@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191212231213.29061-1-jquinlan@broadcom.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/12/19 3:12 PM, Jim Quinlan wrote:
> Otherwise one may get multiple error messages for normal
> operation of a clock provider.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
