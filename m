From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v2] spi: gpio: prevent memory leak in spi_gpio_probe
Date: Tue, 1 Oct 2019 11:11:34 +0200
Message-ID: <6b55e753-5797-2bdc-fae6-f575a0ef8186@web.de>
References: <20190930205241.5483-1-navid.emamdoost@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190930205241.5483-1-navid.emamdoost@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> =E2=80=A6 In order to avoid leak spi_contriller_put must
> be called in case of failure for devm_add_action_or_reset.

How does this wording fit to the diff display that you would like
to add the function call =E2=80=9Cspi_master_put(master)=E2=80=9D in
one if branch?


> Fixes: 8b797490b4db ("spi: gpio: Make sure spi_master_put() is called in=
 every error path")

Is there a need to complete the corresponding exception handling
at any more source code places?

Regards,
Markus
