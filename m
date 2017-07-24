From: Anton Volkov <avolkov-ufN2psIa012HXe+LvDLADg@public.gmane.org>
Subject: Possible race in spi-tegra114.ko
Date: Mon, 24 Jul 2017 15:30:36 +0300
Message-ID: <2cf0b5d2-1b04-1380-0930-b7a28b35bf99@ispras.ru>
References: <2a037d00f975d05e41fb1164711e6813@rainloop.ispras.ru>
 <81025e89755197b09309794e3e08795b@rainloop.ispras.ru>
 <1013edec2ddb1fb49a0d5503179b20d6@rainloop.ispras.ru>
 <8a2122f5efa1082943906a44af8d23cd@rainloop.ispras.ru>
 <5db42bb986f91d2a55ffdd9b5253ad7c@rainloop.ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ldv-project-tpLiQldItUH5n4uC9ZG1Ww@public.gmane.org,
        khoroshilov-ufN2psIa012HXe+LvDLADg@public.gmane.org
To: ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5db42bb986f91d2a55ffdd9b5253ad7c-DwCxqXnXFIIDQsdXxHp7QS8mxiWnj2XH@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello.
While searching for races in Linux kernel I've come across 
drivers/spi/spi-tegra114.ko module. Here is the question that I came up 
with while analysing results. Lines are given using the info from Linux 
v4.12.

Consider the following case:
Thread 1:                                  Thread 2:
tegra_spi_probe
   -> request_threaded_irq
       (spi-tegra114.c: line 1070)
   ------------interrupt comes------------- tegra_spi_isr_thread
                                              -> handle_dma_based_xfer
                                                   -> 
tegra_spi_start_dma_based_transfer
                                                        -> 
tegra_spi_copy_client_txbuf_to_spi_txbuf
                                                             -> 
dma_sync_single_for_cpu(tspi->dev, tspi->tx_dma_phys, ...) 
(spi-tegra114.c: line 368)
   -> tspi->tx_dma_phys = ...
      (spi-tegra114.c: line 621 or 625)

If the situation above is feasible then the value of tspi->tx_dma_phys 
(which is 0) is passed to dma_sync_single_for_cpu and further down the 
callstack. This is probably not good.
Note that other fields of tspi structure can also be affected using the 
similar templates.
Similar cases can occur also for tspi structure in 
drivers/spi/spi-tegra20-slink.ko module and for tsd structure in 
drivers/spi/spi-tegra20-sflash.ko module.
So the question is: is there a possibility of interrupt triggering 
before the registration of master (spi-tegra114.c: line 1125) or a write 
to tspi->def_command1_reg (spi-tegra114.c: line 1121)?

Thank you for your time.

-- Anton Volkov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: avolkov-ufN2psIa012HXe+LvDLADg@public.gmane.org <mailto:avolkov-ufN2psIa012HXe+LvDLADg@public.gmane.org>
