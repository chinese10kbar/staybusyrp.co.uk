QBShared = QBShared or {}
QBShared.Vehicles = QBShared.Vehicles or {}

local Vehicles = {

    --- Police (5)
    {['model'] = 'a4-unmarked',          ['name'] = 'POLICE AUDI A4',                   ['brand'] = 'AUDI',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'ERT8',          ['name'] = 'BMW 2 Series Marked',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'ERT9',          ['name'] = 'Peugeot 308 Marked',                   ['brand'] = 'Peugeot',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'ERT23',          ['name'] = 'FORD Transit Van',                   ['brand'] = 'Ford',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'jagf',          ['name'] = 'Jaguar F Pace',                   ['brand'] = 'Jaguar',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'jagxf',          ['name'] = 'Jaguar XFR',                   ['brand'] = 'Jaguar',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'm5f90',          ['name'] = 'BMW M5 F90',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 's4m',          ['name'] = 'POLICE AUDI A4',                   ['brand'] = 'AUDI',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'ERT20',          ['name'] = 'Sprinter Van Marked',                   ['brand'] = 'Mercedes',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'pol_bmw1',          ['name'] = 'BMW 3 Series Unmarked',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'pol_subaru',          ['name'] = 'Subaru Marked',                   ['brand'] = 'SUBARU',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'polarvgud',          ['name'] = 'BMW 330i',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'polastra',          ['name'] = 'Vauxhall Astra Marked',                   ['brand'] = 'Vauxhall',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'poldirtb',          ['name'] = 'POLICE AUDI A4',                   ['brand'] = 'AUDI',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'polgolf',          ['name'] = 'Golf Unmarked',                   ['brand'] = 'Volkswagen',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'policeb',          ['name'] = 'R900RTP Bike',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'polrange',          ['name'] = 'Range Rover SVR Marked',                   ['brand'] = 'Range Rover',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'unmarkeda6',          ['name'] = 'Audi A6 Unmarked',                   ['brand'] = 'Audi',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'unmarkeda45',          ['name'] = 'Benz A45 Unmarked',                   ['brand'] = 'Mercedes',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'pursport',          ['name'] = 'Bugatti Chiron',                   ['brand'] = 'Bugatti',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'nm_ctsv',          ['name'] = 'Cadillac CTS-V',                   ['brand'] = 'Cadillac',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'psenna',          ['name'] = 'Mclaren Senna',                   ['brand'] = 'Mclaren',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'x5f15',          ['name'] = 'BMW X5F15',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'x6mpd',          ['name'] = 'BMW X6 Unmarked',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'x3m3tour22',          ['name'] = 'BMW M3 Touring Unmarked',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'rs318',          ['name'] = 'AUDI RS3 Sportback Unmarked',                   ['brand'] = 'AUDI',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'rs322sedancarbontels',          ['name'] = 'AUDI RS3 Sedan Unmarked',                   ['brand'] = 'AUDI',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'r35kream',          ['name'] = 'Nissan GT-R Unmarked',                   ['brand'] = 'Nissan',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'pctp',          ['name'] = 'Porsche Cayenne Unmarked',                   ['brand'] = 'Porsche',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'fordrsc',          ['name'] = 'Ford Focus RS Unmarked',                   ['brand'] = 'Ford',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'm140icun',          ['name'] = 'BMW M140 I',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'rj71ygc',          ['name'] = 'BMW X5 Unmarked',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'km72mte',          ['name'] = 'Range Rover Unmarked',                   ['brand'] = 'Range Rover',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'VRESG05',          ['name'] = 'BMW X5 GO5 Marked',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'SegG3001',          ['name'] = 'BMW 3 Series',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'FX22FMC',          ['name'] = 'Volvo XC 90',                   ['brand'] = 'Volvo',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'bmwm2els',          ['name'] = 'BMW M2 Marked',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'npas',          ['name'] = 'npas',                   ['brand'] = 'EUROCOPTER',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = 'm2cs20',          ['name'] = 'm2cs20',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    {['model'] = '4x4range',          ['name'] = '4x4range',                   ['brand'] = '4x4 Range Rover',           ['price'] = 100000,  ['categoryLabel'] = 'Police',       ['shop'] = 'none'},
    --- NHS (6)
    {['model'] = 'x5nhs',          ['name'] = 'NHS X5',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'NHS',       ['shop'] = 'none'},
    {['model'] = 'octavia2010',          ['name'] = 'NHS Octavia Estate',                   ['brand'] = 'Skoda',           ['price'] = 100000,  ['categoryLabel'] = 'NHS',       ['shop'] = 'none'},
    {['model'] = 'x5aa',          ['name'] = 'NHS X5',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'NHS',       ['shop'] = 'none'},
    {['model'] = 'HEMS1',          ['name'] = 'NHS HEMS HELI',                   ['brand'] = 'EUROCOPTER',           ['price'] = 100000,  ['categoryLabel'] = 'NHS',       ['shop'] = 'none'},
    {['model'] = 'Nhsbike',          ['name'] = 'NHS R1200RT',                   ['brand'] = 'BMW',           ['price'] = 100000,  ['categoryLabel'] = 'NHS',       ['shop'] = 'none'},
    {['model'] = 'nhsc8',          ['name'] = 'NHS X5 RS6',                   ['brand'] = 'AUDI',           ['price'] = 100000,  ['categoryLabel'] = 'NHS',       ['shop'] = 'none'},
    {['model'] = 'nhsfiat',          ['name'] = 'NHS FIAT VAN',                   ['brand'] = 'FIAT',           ['price'] = 100000,  ['categoryLabel'] = 'NHS',       ['shop'] = 'none'},
    {['model'] = 'nhsmerc',          ['name'] = 'NHS MERC',                   ['brand'] = 'MERCEDES',           ['price'] = 100000,  ['categoryLabel'] = 'NHS',       ['shop'] = 'none'},
    {['model'] = 'nhsq8',          ['name'] = 'NHS RSQ8',                   ['brand'] = 'AUDI',           ['price'] = 100000,  ['categoryLabel'] = 'NHS',       ['shop'] = 'none'},
    {['model'] = 'nhsrs7',          ['name'] = 'NHS RS7',                   ['brand'] = 'AUDI',           ['price'] = 100000,  ['categoryLabel'] = 'NHS',       ['shop'] = 'none'},
}

for i=1, #Vehicles do
    QBShared.Vehicles[Vehicles[i].model] = {
        spawncode = Vehicles[i].model,
        name = Vehicles[i].name,
        brand = Vehicles[i].brand,
        model = Vehicles[i].model,
        price = Vehicles[i].price,
        category = Vehicles[i].categoryLabel:gsub("%s+", ""):lower(),
        categoryLabel = Vehicles[i].categoryLabel,
        hash = joaat(Vehicles[i].model),
        shop = Vehicles[i].shop
    }
end