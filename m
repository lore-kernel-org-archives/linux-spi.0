From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RESEND PATCH] spi: bcm63xx-hsspi: Export OF device ID table as
 module aliases
Date: Fri, 5 May 2017 14:07:47 -0700
Message-ID: <e8ef8838-156c-a9be-7079-c0b4e645f500@gmail.com>
References: <20170501201338.5368-1-andresgalacho@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Andres Galacho <andresgalacho@gmail.com>,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170501201338.5368-1-andresgalacho@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 05/01/2017 01:13 PM, Andres Galacho wrote:
> The device table is required to load modules based on
> modaliases. After adding MODULE_DEVICE_TABLE, below entries
> for example will be added to module.alias:
> alias:          of:N*T*Cbrcm,bcm6328-hsspiC*
> alias:          of:N*T*Cbrcm,bcm6328-hsspi
> 
> Signed-off-by: Andres Galacho <andresgalacho@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
