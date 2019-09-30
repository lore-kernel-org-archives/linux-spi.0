From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: Re: [PATCH] spi: gpio: prevent memory leak in spi_gpio_probe
Date: Mon, 30 Sep 2019 15:54:43 -0500
Message-ID: <CAEkB2ES3kKSU+mQojZHrzMaeQZhjRUoLe+4wOaZONGT=OwRc4g@mail.gmail.com>
References: <20190930033928.32312-1-navid.emamdoost@gmail.com> <dcd26f62-e384-bf6d-2e7d-63c0d0f7da11@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi@vger.kernel.org, Navid Emamdoost <emamd001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Stephen McCamant <smccaman@umn.edu>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dcd26f62-e384-bf6d-2e7d-63c0d0f7da11@web.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Fixed the issues in v2.

Thanks,
Navid.

On Mon, Sep 30, 2019 at 1:24 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> * Please avoid typos in the commit message.
>
> * I would prefer an other wording for the change description.
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=97f9a3c4eee55b0178b518ae7114a6a53372913d#n151
>
>
> Regards,
> Markus



-- 
Navid.
