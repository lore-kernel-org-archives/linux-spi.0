From: Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [RESEND PATCH] spi: bcm63xx-hsspi: Export OF device ID table as
 module aliases
Date: Tue, 2 May 2017 16:00:53 +0200
Message-ID: <CAOiHx=mex7CDCP0dGtjdmENPx0oe2XexPLyF3DP=GPgUJXQT_w@mail.gmail.com>
References: <20170501201338.5368-1-andresgalacho@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-spi@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: Andres Galacho <andresgalacho@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170501201338.5368-1-andresgalacho@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 1 May 2017 at 22:13, Andres Galacho <andresgalacho@gmail.com> wrote:
> The device table is required to load modules based on
> modaliases. After adding MODULE_DEVICE_TABLE, below entries
> for example will be added to module.alias:
> alias:          of:N*T*Cbrcm,bcm6328-hsspiC*
> alias:          of:N*T*Cbrcm,bcm6328-hsspi
>
> Signed-off-by: Andres Galacho <andresgalacho@gmail.com>

Not that it matters much with a trivial patch like this, but

Acked-by: Jonas Gorski <jonas.gorski@gmail.com>

also thanks for doing it.


Regards
Jonas
